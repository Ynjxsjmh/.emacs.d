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

;;------------------------------------------------------------------------------
;; minor changes
;;------------------------------------------------------------------------------

;; 不让光标闪
(blink-cursor-mode 0)

;; maximize the window
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 设置展开 yasnippet 的时候不需要空格
;; see https://github.com/joaotavora/yasnippet/issues/612
(eval-after-load 'yasnippet
  '(add-to-list 'yas-key-syntaxes 'yas-longest-key-from-whitespace))

;; 不用 eval 在evil-commands.el提供的 (evil-paste-last-insertion)
;; (global-set-key (kbd "C-a") 'move-beginning-of-line)
;; (evil-define-key 'nil 'global-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-p") 'previous-line)
(define-key evil-insert-state-map (kbd "C-n") 'next-line)

(setq org-latex-toc-command "\\tableofcontents \\clearpage")

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

;;------------------------------------------------------------------------------
(setq company-clang-arguments
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
 C:\\CodeBlocksMinGW\\lib\\gcc\\mingw32\\5.1.0\\include\\c++
 C:\\CodeBlocksMinGW\\lib\\gcc\\mingw32\\5.1.0\\include\\c++\\mingw32
 C:\\CodeBlocksMinGW\\lib\\gcc\\mingw32\\5.1.0\\include\\c++\\backward
 C:\\CodeBlocksMinGW\\lib\\gcc\\mingw32\\5.1.0\\include
 C:\\CodeBlocksMinGW\\include
 C:\\CodeBlocksMinGW\\lib\\gcc\\mingw32\\5.1.0\\include-fixed
"
               )))

;;------------------------------------------------------------------------------

(provide 'my-init)