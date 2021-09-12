
(require 'counsel)

;; https://emacs-china.org/t/emacs-rg-buffer/8347/4
(let ((command
         (cond
          ((executable-find "rg")
           "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
          ((executable-find "pt")
           "pt -zS --nocolor --nogroup -e %s")
          (t counsel-grep-base-command))))
    (setq counsel-grep-base-command command))

(setq-default header-line-format '("   " default-directory))

;; | 功能             | 原生        | evil-mode |
;; | hs-hide-block    | C-c @ C-h   | zc        |
;; | hs-show-block    | C-c @ C-s   | zo        |
;; | hs-hide-all      | C-c @ C-M-h | zm        |
;; | hs-show-all      | C-c @ C-M-s | zr        |
;; | hs-hide-level    | C-c @ C-l   | 无        |
;; | hs-toggle-hiding | C-c @ C-c   | za        |
(require 'hideshow)

(add-hook 'prog-mode-hook 'hs-minor-mode)

;; https://github.com/condy0919/emacs-newbie/blob/master/introduction-to-builtin-modes.md#hideshow
;; 额外启用了 :box t 属性使得提示更加明显
(defconst hideshow-folded-face '((t (:inherit 'font-lock-comment-face :box t))))

(defun hideshow-folded-overlay-fn (ov)
    (when (eq 'code (overlay-get ov 'hs))
      (let* ((nlines (count-lines (overlay-start ov) (overlay-end ov)))
             (info (format " ... #%d " nlines)))
        (overlay-put ov 'display (propertize info 'face hideshow-folded-face)))))

(setq hs-set-up-overlay 'hideshow-folded-overlay-fn)

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

(add-hook 'python-mode-hook 'my/replace-hs-special)

;; Syntax highlighting for systemd files
(require 'conf-mode)
(let ((system-file (rx "."
                       (or "automount" "busname" "link" "mount" "netdev" "network"
                           "path" "service" "slice" "socket" "swap" "target" "timer")
                       string-end)))
  (add-to-list 'auto-mode-alist `(,system-file . conf-toml-mode)))

;;------------------------------------------------------------------------------
;; minor changes
;;------------------------------------------------------------------------------

;; 不让光标闪
(blink-cursor-mode 0)

(setq delete-by-moving-to-trash t)

(load-theme 'doom-solarized-light t)

(unless (display-graphic-p)
  (require 'clipetty)
  (global-clipetty-mode)
  (global-set-key (kbd "M-w") 'clipetty-kill-ring-save)
  (custom-set-faces
   '(line-number-current-line ((t (:inherit (hl-line default) :background "#e5e1d2" :foreground "#556b72" :strike-through nil :underline nil :slant normal :weight bold))))
   '(magit-diff-added-highlight ((t (:extend t :background "#e5e3b5" :foreground "#859900" :weight bold))))
   '(magit-diff-removed-highlight ((t (:extend t :background "#edc2ae" :foreground "#dc322f" :weight bold))))
   '(widget-field ((t (:extend t :background "cyan" :foreground "#2d2d2d"))))))

;; maximize the window
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 设置展开 yasnippet 的时候不需要空格
;; see https://github.com/joaotavora/yasnippet/issues/612
(eval-after-load 'yasnippet
  '(add-to-list 'yas-key-syntaxes 'yas-longest-key-from-whitespace))

;; 不用 eval 在evil-commands.el提供的 (evil-paste-last-insertion)
;; (global-set-key (kbd "C-a") 'move-beginning-of-line)
;; (evil-define-key 'nil 'global-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-p") 'previous-line)
(define-key evil-insert-state-map (kbd "C-n") 'next-line)

(add-to-list 'auto-mode-alist '("/\\.gitclone\\'" . gitconfig-mode))

;;------------------------------------------------------------------------------
;; my function
;;------------------------------------------------------------------------------

(defun markdown-to-html ()
  (interactive)
  (start-process "grip" "*gfm-to-html*" "grip" (buffer-file-name) "5000")
  (browse-url (format "http://localhost:5000/%s.%s" (file-name-base) (file-name-extension (buffer-file-name)))))
(global-set-key (kbd "C-c m")   'markdown-to-html)  ;给函数绑定一个快捷键

(defun douban-org-toc ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (let* ((lb (line-beginning-position))
             (le (line-end-position))
             (ln (buffer-substring-no-properties lb le))
             (heading (car (split-string ln " ")))
             (count (length (split-string heading "\\."))))
        (beginning-of-line)
        (insert (make-string count ?*))
        (insert " ")
        (forward-line 1)))))

(require 'elec-pair)

;; 把弯引号左右对调重新添加到补全列表
(setq electric-pair-pairs
      `(,@electric-pair-pairs
        (?’ . ?‘)
        (?” . ?“)))

;; 修正左右对调的补全
(define-advice electric-pair--insert (:around (orig-fn c) fix-curved-quotes)
  (let* ((qpair (rassoc c electric-pair-pairs))
         (reverse-p (and qpair (> (car qpair) (cdr qpair)))))
    (if reverse-p
        (run-with-timer 0 nil
                        `(lambda ()
                           (backward-char 1)
                           (insert (char-to-string ,c))))
      (funcall orig-fn c))))

;;------------------------------------------------------------------------------

;; https://wikemacs.org/wiki/Emacs_Lisp_Cookbook
(defun bracket-to-dollar (start end)
	(interactive "r")
	(narrow-to-region start end)
	(goto-char 1)
	(while (search-forward "\\[" nil t)
        (replace-match "$$"))
	(goto-char 1)
	(while (search-forward "\\]" nil t)
        (replace-match "$$"))
	(goto-char 1)
	(while (search-forward "\\(" nil t)
        (replace-match "$"))
	(goto-char 1)
	(while (search-forward "\\)" nil t)
        (replace-match "$"))
)

;;------------------------------------------------------------------------------

(provide 'init-miscellanies)
;;; init-miscellanies.el ends here
