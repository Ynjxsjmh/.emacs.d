(server-start)

(require 'org-protocol)

;; Templates for browser extension `org-capture-extension`
;; https://lists.gnu.org/archive/html/emacs-orgmode/2015-10/msg00101.html
;; (setq org-capture-templates (append org-capture-templates
;;  	                                '(("p" "Protocol" entry
;;                                        (file "E:/sourcecode/note/refile.org")
;;                                        "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n%?")
;; 	                                  ("L" "Protocol Link" entry
;;                                        (file "E:/sourcecode/note/refile.org")
;;                                        "* %? [[%:link][%:description]] \nCaptured On: %U"))))

(provide 'init-org-protocol)
;;; init-org-protocol.el ends here