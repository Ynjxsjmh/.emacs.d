
;; https://emacs-china.org/t/emacs-rg-buffer/8347/4
(let ((command
         (cond
          ((executable-find "rg")
           "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
          ((executable-find "pt")
           "pt -zS --nocolor --nogroup -e %s")
          (t counsel-grep-base-command))))
    (setq counsel-grep-base-command command))


(provide 'init-miscellanies)
;;; init-miscellanies.el ends here
