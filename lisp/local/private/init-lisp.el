(require 'paredit)
(require 'rainbow-delimiters)

;; https://www.reddit.com/r/emacs/comments/4zy44s/question_in_emacs_lisp_or_lisp_how_do_you_guys/d6zsiue
(add-hook  'emacs-lisp-mode-hook
           (lambda ()
             ;;(setq show-paren-style 'parenthesis)
             ;;(setq show-paren-delay 0)
             (show-paren-mode 1)
             #'turn-on-auto-fill
             (rainbow-delimiters-mode t)
             (paredit-mode t)
             ))

(add-hook  'lisp-interaction-mode
           (lambda ()
             ;;(setq show-paren-style 'expression)
             ;;(setq show-paren-delay 0)
             (show-paren-mode 1)
             #'turn-on-auto-fill
             (rainbow-delimiters-mode t)
             (paredit-mode t)
             ))

(provide 'init-lisp)
;;; init-lisp.el ends here