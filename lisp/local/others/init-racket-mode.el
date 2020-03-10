(require 'racket-mode)

(setq tab-always-indent 'complete)

(add-auto-mode 'racket-mode "\\.rkt\\'")

(setq auto-mode-alist
  (append auto-mode-alist
          '(("\\.rkt\\'" . racket-mode))
   ))

(provide 'init-racket-mode)
;;; init-racket-mode.el ends here