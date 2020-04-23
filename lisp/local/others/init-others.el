;; 原来管理包的方式感觉过于复杂，如果那个包不做什么配置直接require得了，不新建对应的 init 文件了

;; List of visible packages from melpa-unstable (http://melpa.org).
;; Please add the package name into `melpa-include-packages'
;; if it's not visible after  `list-packages'.
(setq melpa-include-packages (append melpa-include-packages
                                     '(
	                                   flymd
                                       lsp-haskell
                                       outline-magic
                                       quickrun
                                       org-noter
                                       faceup
                                       racket-mode
                                       org-rich-yank
                                       ob-ipython
                                       )))



;; 包可以在 MELPA 或 ELPA 上找到的，但是自己下的，与之前 redguard 下的做区分

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
(require 'init-find-file-in-project)
(require 'init-ivy)
(require 'init-racket-mode)
(require 'ahk-mode)
(require 'init-elpy)
(require 'init-maple-header)
(require 'ob-ipython)

;; 别人写的，但包不可以在 MELPA 或 ELPA 上找到的

(require 'init-aweshell)
(require 'init-beancount)
(require 'init-org-protocol-capture-html)
(require 'init-sly-el-indent)
(require 'init-flywrap)
(require 'init-color-rg)



(provide 'init-others)
;;; init-others.el ends here