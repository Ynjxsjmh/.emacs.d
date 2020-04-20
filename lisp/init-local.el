;; 用于 require 和 lisp 目录下重复的文件
(defun require-local (pkg &optional maybe-disabled)
  "Load PKG if MAYBE-DISABLED is nil or it's nil but start up in normal slowly."
  (when (or (not maybe-disabled) (not (boundp 'startup-now)))
    (load (file-truename (format "~/.emacs.d/lisp/local/private/%s" pkg)) t t)))

(require-package 'org-download)
(require-package 'flymd)
(require-package 'auctex)
(require-package 'ox-gfm)
(require-package 'ghc)
(require-package 'graphviz-dot-mode)
(require-package 'py-autopep8)
(require-package 'lsp-mode)
(require-package 'pangu-spacing)
(require-package 'markdown-toc)
(require-package 'skeleton)

(push (expand-file-name "~/.emacs.d/lisp") load-path)
(push (expand-file-name "~/.emacs.d/lisp/local/private") load-path)
(push (expand-file-name "~/.emacs.d/lisp/local/others") load-path)

(let ((default-directory "~/.emacs.d/individual/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'init-others)
(require 'init-private)     ;; 自己写的

(provide 'init-local)
;;; init-local.el ends here