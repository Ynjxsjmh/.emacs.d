
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

(setq-default header-line-format '(" %l %b " default-directory))

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

;;------------------------------------------------------------------------------
;; minor changes
;;------------------------------------------------------------------------------

;; 不让光标闪
(blink-cursor-mode 0)

(setq delete-by-moving-to-trash t)

(if (display-graphic-p)
    (load-theme 'doom-solarized-light t)
  (load-theme 'sanityinc-tomorrow-eighties t))

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

(setq org-latex-toc-command "\\tableofcontents \\clearpage")

(add-to-list 'auto-mode-alist '("/\\.gitclone\\'" . gitconfig-mode))

;;------------------------------------------------------------------------------
;; my function
;;------------------------------------------------------------------------------

(defun markdown-to-html ()
  (interactive)
  (start-process "grip" "*gfm-to-html*" "grip" (buffer-file-name) "5000")
  (browse-url (format "http://localhost:5000/%s.%s" (file-name-base) (file-name-extension (buffer-file-name)))))
(global-set-key (kbd "C-c m")   'markdown-to-html)  ;给函数绑定一个快捷键

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
