(require 'adoc-mode)

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
(eval-after-load 'outline
  '(progn
    (require 'outline-magic)
    (define-key outline-minor-mode-map (kbd "<tab>") 'outline-cycle)))

(provide 'init-adoc-mode)