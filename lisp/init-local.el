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

(push (expand-file-name "~/.emacs.d/lisp") load-path)
(push (expand-file-name "~/.emacs.d/lisp/local/private") load-path)
(push (expand-file-name "~/.emacs.d/lisp/local/personal") load-path)
(push (expand-file-name "~/.emacs.d/lisp/local/individual") load-path)

(require 'init-private)
(require 'init-personal)
(require 'init-individual)

(provide 'init-local)
;;; init-local.el ends here