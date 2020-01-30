(require 'pangu-spacing)

(global-pangu-spacing-mode 1)

(add-hook 'markdown-mode-hook
          '(lambda ()
           (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))

(add-hook 'adoc-mode-hook
          '(lambda ()
           (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))

(provide 'init-pangu-spacing)