;; 包可以在 MELPA 或 ELPA 上找到的，但是自己下的

(require 'init-org-download)
(require 'init-flymd)
(require 'init-auctex)
(require 'init-ox-gfm)
(require 'init-ghc)
;; (void-variable default-tab-width) problem, check https://github.com/ppareit/graphviz-dot-mode/pull/24
;; Meanwhile delete graphviz-dot-mode.elc
(require 'init-graphviz-dot-mode)
;; py-autopep8 is horrible with auto save
;; (require 'init-py-autopep8)
(require 'init-lsp-mode)
(require 'init-pangu-spacing)
(require 'init-markdown-toc)
(require 'init-quickrun)
(require 'init-adoc-mode)

(provide 'init-personal)