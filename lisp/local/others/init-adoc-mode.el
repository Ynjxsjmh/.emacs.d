;; -*- coding: utf-8; lexical-binding: t; -*-

(require 'adoc-mode)
(require 'hydra)

;; C-c @ C-a       show-all
;; C-c @ C-c       hide-entry
;; C-c @ C-d       hide-subtree
;; C-c @ C-e       show-entry
;; C-c @ TAB       show-children
;; C-c @ C-k       show-branches
;; C-c @ C-l       hide-leaves
;; C-c @ C-o       hide-other
;; C-c @ C-q       hide-sublevels
;; C-c @ C-s       show-subtree
;; C-c @ C-t       hide-body
;; (add-hook 'adoc-mode-hook #'outline-minor-mode)

;; fold and unfold sections of text function
;; https://emacs.stackexchange.com/questions/361/how-can-i-hide-display-latex-section-just-like-org-mode-does-with-headlines

;; http://wikemacs.org/wiki/Outline
(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (define-key outline-minor-mode-map  (kbd "<tab>") 'outline-cycle)))

(add-hook 'adoc-mode-hook
          (lambda ()
            (outline-minor-mode)
))


(setq adoc-publishing-blog-directory "e:/sourcecode/myblog/_posts/")

(defun convert-asciidoc-to-html (&optional target-directory)
  (interactive)
  (if target-directory
      (shell-command (format "asciidoctor \"%s\" -D \"%s\"" buffer-file-name target-directory))
    (shell-command (format "asciidoctor \"%s\"" buffer-file-name))
      )
  )


(defhydra hydra-adoc (:color pink)
  "
_h_ Export to HTML
_b_ Export to HTML To Blog
"
  ("h" convert-asciidoc-to-html nil :exit t)
  ("b" (convert-asciidoc-to-html adoc-publishing-blog-directory) nil :exit t)
  ("q" nil "quit"))
(define-key adoc-mode-map (kbd "C-c C-e") 'hydra-adoc/body)


(provide 'init-adoc-mode)