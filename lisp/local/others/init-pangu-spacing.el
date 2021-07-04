(require 'pangu-spacing)

(global-pangu-spacing-mode 1)

;; only insert real whitespace in some specific mode, but just add virtual space in other mode

(add-hook 'org-mode-hook
          '(lambda ()
             (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))

(add-hook 'adoc-mode-hook
          '(lambda ()
           (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)))

(provide 'init-pangu-spacing)