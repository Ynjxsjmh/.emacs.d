;;LaTeX config
(add-hook 'LaTeX-mode-hook
        (lambda ()
          (add-to-list 'tex-compile-commands '("xelatex --shell-escape -interaction nonstopmode -output-directory %o %f" t "%r.pdf"))
          (setq TeX-auto-untabify t     ; remove all tabs before saving
                TeX-show-compilation t  ; display compilation windows
                TeX-save-query nil
                TeX-engine 'xetex       ; use xelatex default
                ;; TeX-command-default "XeLaTeX"
                )
          (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
          (imenu-add-menubar-index)
          (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))


(add-hook 'LaTeX-mode-hook #'latex-extra-mode)

(provide 'init-latex)