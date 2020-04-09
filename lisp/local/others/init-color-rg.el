(require 'color-rg)

;; https://emacs.stackexchange.com/a/10588/22102
(eval-after-load 'color-rg
  '(progn
     (evil-make-overriding-map color-rg-mode-map 'normal)
     ;; force update evil keymaps after git-timemachine-mode loaded
     (add-hook 'color-rg-mode-hook #'evil-normalize-keymaps)))

(provide 'init-color-rg)
;;; init-color-rg.el ends here
