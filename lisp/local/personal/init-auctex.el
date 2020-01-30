(require 'cdlatex)

(load "auctex.el" nil t t)
(load "preview.el" nil t t)

;; copy from <https://www.emacswiki.org/emacs/AUCTeX#toc2>
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)


;; copy from <https://www.emacswiki.org/emacs/AUCTeX#toc5>
(setq TeX-PDF-mode t)
(require 'tex)
    (TeX-global-PDF-mode t)

;; 将cdlatex设置为AUCtex的辅模式
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(add-hook 'latex-mode-hook 'turn-on-cdlatex)

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(provide 'init-auctex)