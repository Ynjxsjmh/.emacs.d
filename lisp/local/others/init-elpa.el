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

(require-package 'org-download)
(require-package 'flymd)
(require-package 'cdlatex)
(require-package 'auctex)
(require-package 'ox-gfm)
(require-package 'ghc)
(require-package 'graphviz-dot-mode)
(require-package 'py-autopep8)
(require-package 'pangu-spacing)
(require-package 'markdown-toc)
(require-package 'skeleton)
(require-package 'quickrun)
(require-package 'ahk-mode)
(require-package 'racket-mode)
(require-package 'ob-ipython)
(require-package 'org-bullets)


(provide 'init-elpa)
;;; init-elpa.el ends here
