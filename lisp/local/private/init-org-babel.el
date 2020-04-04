;; init org-babel
;; Copy and edit from https://github.com/purcell/emacs.d/blob/master/lisp/init-org.el#L385
(org-babel-do-load-languages
	'org-babel-load-languages
		`((C . t)
		 (ditaa . t)
		 (dot . t)
		 (emacs-lisp . t)
		 (gnuplot . t)
		 (haskell . nil)
         (ipython . t)
		 (java . t)
         (js . t)
		 (latex . t)
		 (ledger . t)
		 (ocaml . nil)
		 (octave . t)
         (perl . t)
		 (plantuml . t)
		 (python . t)
         (R . t)
		 (ruby . t)
		 (rust . t)
		 (screen . nil)
		 (shell . t)
		 (sql . t)
		 (sqlite . t)))

;; don't prompt me to confirm everytime I want to evaluate a block
(setq org-confirm-babel-evaluate nil)

;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

(provide 'init-org-babel)