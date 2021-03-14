;; 自己写的

;; 用于 require 和 lisp 目录下重复的文件
(defun require-local (pkg &optional maybe-disabled)
  "Load PKG if MAYBE-DISABLED is nil or it's nil but start up in normal slowly."
  (when (or (not maybe-disabled) (not (boundp 'startup-now)))
    (load (file-truename (format "~/.emacs.d/lisp/local/private/%s" pkg)) t t)))

(require 'init-gtd)
(require-local 'init-org)
(require 'init-org-babel)
(require 'init-org-protocol)
(require 'init-org-publish-project)
(require 'init-font-settings)
(require 'init-encoding)
(require 'init-latex)
(require 'init-html-converter)
(require 'init-miscellanies)
(require 'init-whitespace-killer)
(require 'init-blog-post)
(require-local 'init-lisp)
(require 'init-epub)
(require 'init-auto-insert)

(provide 'init-private)