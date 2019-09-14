(add-to-list 'load-path "~/.emacs.d/individual/beancount")

(require 'beancount)

(add-to-list 'auto-mode-alist '("\\.bean\\'" . beancount-mode))

(provide 'init-beancount)