;; https://github.com/Linusp/Linusp.github.io
;; Write Blog
(defvar post-dir "d:/Dropbox/blog/")
(defun blog-post (input-filetype post-title)
  (interactive "sChoose filetype: [a]sciidoc [o]rg [m]arkdown: \nsEnter titile: ")

  (defvar post-filetype nil)

  (cond ((string= input-filetype "a") (setq post-filetype "adoc"))
        ((string= input-filetype "o") (setq post-filetype "org"))
        ((string= input-filetype "m") (setq post-filetype "md"))
        (t (setq post-filetype "adoc")))

  (let ((post-file (concat post-dir
                           (format-time-string "%Y-%m-%d")
                           "-"
                           post-title
                           "."
                           post-filetype)))
    (progn
      (switch-to-buffer (find-file-noselect post-file)))))


(define-key global-map (kbd "C-c C-p") 'blog-post)

(provide 'init-blog-post)
;;; init-blog-post.el ends here