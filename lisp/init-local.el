(push (expand-file-name "~/.emacs.d/lisp") load-path)
(push (expand-file-name "~/.emacs.d/lisp/local/private") load-path)
(push (expand-file-name "~/.emacs.d/lisp/local/others") load-path)

(let ((default-directory "~/.emacs.d/individual/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'init-others)
(require 'init-private)     ;; 自己写的

(provide 'init-local)
;;; init-local.el ends here