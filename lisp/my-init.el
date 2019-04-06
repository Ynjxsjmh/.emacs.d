(require-package 'org-download)
(require-package 'flymd)
(require-package 'auctex)
(require-package 'ox-gfm)
(require-package 'ghc)
(require-package 'graphviz-dot-mode)
(require-package 'py-autopep8)
(require-package 'lsp-mode)

(push (expand-file-name "~/.emacs.d/lisp") load-path)
(require 'init-org-download)
(require 'init-font-settings)
(require 'init-flymd)
(require 'init-auctex)
(require 'init-ox-gfm)
(require 'init-ghc)
;; py-autopep8 is horrible with auto save
;; (require 'init-py-autopep8)
(require 'init-lsp-mode)


;; (void-variable default-tab-width) problem, check https://github.com/ppareit/graphviz-dot-mode/pull/24
;; Meanwhile delete graphviz-dot-mode.elc
(require 'init-graphviz-dot-mode)

;;------------------------------------------------------------------------------
;; minor changes
;;------------------------------------------------------------------------------

;; 不让光标闪
(blink-cursor-mode 0)

;; maximize the window
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;;设置默认读入文件编码
(prefer-coding-system 'utf-8)
;;设置写入文件编码
(setq default-buffer-file-coding-system 'utf-8)

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

;;------------------------------------------------------------------------------
;; my function
;;------------------------------------------------------------------------------

(defun markdown-to-html ()
  (interactive)
  (start-process "grip" "*gfm-to-html*" "grip" (buffer-file-name) "5000")
  (browse-url (format "http://localhost:5000/%s.%s" (file-name-base) (file-name-extension (buffer-file-name)))))
(global-set-key (kbd "C-c m")   'markdown-to-html)  ;给函数绑定一个快捷键

;;------------------------------------------------------------------------------

;; https://wikemacs.org/wiki/Emacs_Lisp_Cookbook
(defun bracket-to-dollar (start end)
	(interactive "r")
	(narrow-to-region start end)
	(goto-char 1)
	(while (search-forward "\\[" nil t)
        (replace-match "$$"))
	(goto-char 1)
	(while (search-forward "\\]" nil t)
        (replace-match "$$"))
	(goto-char 1)
	(while (search-forward "\\(" nil t)
        (replace-match "$"))
	(goto-char 1)
	(while (search-forward "\\)" nil t)
        (replace-match "$"))
)

(provide 'my-init)