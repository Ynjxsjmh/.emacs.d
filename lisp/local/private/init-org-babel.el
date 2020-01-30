;; init org-babel
;; Copy and edit from https://github.com/purcell/emacs.d/blob/master/lisp/init-org.el#L385
(org-babel-do-load-languages
	'org-babel-load-languages
		`((R . t)
		 (C . t)
		 (ditaa . t)
		 (dot . t)
		 (emacs-lisp . t)
		 (gnuplot . t)
		 (haskell . nil)
		 (java . t)
         (js . t)
		 (latex . t)
		 (ledger . t)
		 (ocaml . nil)
		 (octave . t)
		 (plantuml . t)
		 (python . t)
		 (ruby . t)
		 (screen . nil)
		 (shell . t)
		 (sql . t)
		 (sqlite . t)))

(provide 'init-org-babel)