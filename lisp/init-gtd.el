(require 'remember)
(require 'org)


;; Config org-remember
(setq org-remember-templates
      '(("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "E:/sourcecode/Cognition/GTD/newgtd.org" "Tasks")
        ("Journal"   ?j "** %^{Head Line} %U %^g\n%i%?"  "E:/sourcecode/Cognition/GTD/journal.org")
        ("Clipboard" ?c "** %^{Head Line} %U %^g\n%c\n%?"  "E:/sourcecode/Cognition/GTD/journal.org")
        ("Receipt"   ?r "** %^{BriefDesc} %U %^g\n%?"   "E:/sourcecode/Cognition/GTD/finances.org")
        ("Book" ?b "** %^{Book Title} %t :BOOK: \n%[E:/sourcecode/Cognition/.book_template.txt]\n"
         "E:/sourcecode/Cognition/GTD/journal.org")
        ("Film" ?f "** %^{Film Title} %t :FILM: \n%[E:/sourcecode/Cognition/.film_template.txt]\n"
         "E:/sourcecode/Cognition/GTD/journal.org")
        ("Daily Review" ?a "** %t :COACH: \n%[E:/sourcecode/Cognition/.daily_review.txt]\n"
         "E:/sourcecode/Cognition/GTD/journal.org")
        ("Someday" ?s "** %^{Someday Heading} %U\n%?\n"  "E:/sourcecode/Cognition/GTD/someday.org")
        ("Vocab"   ?v "** %^{Word?}\n%?\n"  "E:/sourcecode/Cognition/GTD/vocab.org")
        ("Private" ?p "\n* %^{topic} %T \n%i%?\n" "E:/sourcecode/Cognition/GTD/privnotes.org")
        ("Contact" ?c "\n* %^{Name} :CONTACT:\n%[l:/contemp.txt]\n"
         "E:/sourcecode/Cognition/GTD/privnotes.org")
        )
      )


;; Config org-refile
(setq org-refile-targets '(("newgtd.org" :maxlevel . 1)
                           ("someday.org" :level . 2)
                           ("~/gtd/tickler.org" :maxlevel . 2)
                           ))


;; Config org-agenda
(setq org-agenda-files (list "e:/sourcecode/Cognition/GTD/newgtd.org"
                             "e:/sourcecode/Cognition/GTD/regular.org"
                             "e:/sourcecode/Cognition/GTD/journal.org"))


;; Config org-capture
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-capture-templates
      '(("t" "Task" entry
         (file "E:/sourcecode/note/refile.org")
         "* TODO %?\n")
        ("T" "Clock-in Task" entry
         (file "E:/sourcecode/note/refile.org")
         "* TODO %?\n"
         :clock-in t
         :clock-resume t)
        ("d" "Distraction in a pomodoro" entry
         (file "E:/sourcecode/note/refile.org")
         "* TODO %^{Task}\n  SCHEDULED: %t\n"
         :immediate-finish t)
        ("n" "Note" entry
         (file "E:/sourcecode/note/refile.org")
         "* %?\n")
        ("l" "Note with link to current file" entry
         (file "E:/sourcecode/note/refile.org")
         "* %a")
        ("j" "Journal" entry
         (file+datetree "E:/sourcecode/note/diary.org")
         "* %^{Content}\n"
         :clock-in t
         :clock-resume t)
        ("J" "Journal from Phone" entry
         (file+datetree "E:/sourcecode/note/diary.org")
         "* %^{Content}\n  :LOGBOOK:\n  CLOCK: %^{Begin}U--%^{End}U\n  :END:")
        ("c" "Link from Chrome" entry
         (file "E:/sourcecode/note/refile.org")
         "* %(org-mac-chrome-get-frontmost-url)")
        ("C" "Clock-in Link from Chrome" entry
         (file "E:/sourcecode/note/refile.org")
         "* %(org-mac-chrome-get-frontmost-url)"
         :clock-in t
         :clock-resume t)
        ("p" "People (Contacts)" entry
         (file "E:/sourcecode/note/contacts.org")
         "* %(org-contacts-template-name)\n  :PROPERTIES:\n  :EMAIL: %(org-contacts-template-email)\n  :END:")
        ))


(provide 'init-gtd)