(require 'hideshow)
;; | 功能             | 原生        | evil-mode |
;; | hs-hide-block    | C-c @ C-h   | zc        |
;; | hs-show-block    | C-c @ C-s   | zo        |
;; | hs-hide-all      | C-c @ C-M-h | zm        |
;; | hs-show-all      | C-c @ C-M-s | zr        |
;; | hs-hide-level    | C-c @ C-l   | 无        |
;; | hs-toggle-hiding | C-c @ C-c   | za        |


(unless (memq 'hs-headline mode-line-format)
  (setq mode-line-format
        (append '("-" hs-headline) mode-line-format)))

;; 支持 hideshow 时，显示小箭头
(setq folding-fringe-indicators t)
(when (fboundp 'define-fringe-bitmap)
  (define-fringe-bitmap 'folding-fringe-open-marker
    (vector #b00000000
            #b00000000
            #b00000000
            #b11000011
            #b11100111
            #b01111110
            #b00111100
            #b00011000))

  (define-fringe-bitmap 'folding-fringe-close-marker
    (vector #b01100000
            #b01110000
            #b00111000
            #b00011100
            #b00011100
            #b00111000
            #b01110000
            #b01100000)))

;; 额外启用了 :box t 属性使得提示更加明显
(defconst hideshow-folded-face '((t (:inherit 'font-lock-comment-face :box t))))

(defun hideshow-folded-overlay-fn (ov)
  "Display a folded region indicator with the number of folded lines.
Meant to be used as `hs-set-up-overlay'."
  (let* ((marker-string "*fringe-dummy*")
         (marker-length (length marker-string))
         (close-icon (concat "... " "")))
    (cond
     ((eq 'code (overlay-get ov 'hs))
      (let* ((nlines (count-lines (overlay-start ov) (overlay-end ov)))
             (display-string (format " ... #%d " nlines)))

        ;; fringe indicator
        (when folding-fringe-indicators
          (put-text-property 0 marker-length 'display
                             (list 'left-fringe 'folding-fringe-close-marker)
                             marker-string)
          (overlay-put ov 'before-string marker-string))

        ;; folding indicator
        (put-text-property 0 (length display-string)
                           'mouse-face 'highlight display-string)
        (overlay-put ov 'display (propertize display-string 'face hideshow-folded-face))))

     ;; for docstring and comments, we don't display the number of line
     ((or (eq 'docstring (overlay-get ov 'hs))
          (eq 'comment (overlay-get ov 'hs)))
      (let ((display-string close-icon))
        (put-text-property 0 (length display-string)
                           'mouse-face 'highlight display-string)
        (overlay-put ov 'display display-string))))))

(setq hs-set-up-overlay #'hideshow-folded-overlay-fn)

(add-hook 'prog-mode-hook 'hs-minor-mode)

; hideshow for Python keywords
(defvar my/py-hide-show-keywords '("class" "def" "elif" "else" "except" "async def"
                                   "for" "if" "while" "finally" "try" "with"))

(defun my/replace-hs-special ()
  (setq hs-special-modes-alist
        (remove-if #'(lambda (x) (equal 'python-mode (car x)))
                   hs-special-modes-alist))
  (push (list
         'python-mode
         (mapconcat #'(lambda (x) (concat "^\\s-*" x "\\>"))
                    my/py-hide-show-keywords "\\|")
         "^\\s-*"
         "#"
         #'(lambda (x) (python-nav-end-of-block))
         nil)
        hs-special-modes-alist)
  (hs-grok-mode-type))


(provide 'init-hideshow)
