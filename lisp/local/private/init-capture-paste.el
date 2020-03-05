(setq xbuff (generate-new-buffer "*my output*"))

(defvar github-name "Ynjxsjmh")
(defvar github-repo "ynjxsjmh.github.io")

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
   same directory as the org-buffer and insert a link to this file."
  (interactive)

  (setq date (parse-time-from-buffer-name (buffer-file-name)))

  (if (nth 0 date)
      (setq img-dir (concat "img/" (nth 2 date) "/" (nth 1 date)))
    (setq img-dir "images"))

  (setq absolute-img-dir (concatenate 'string
                                      (file-name-directory (buffer-file-name))
                                      (format "%s/" img-dir)))

  (unless (file-directory-p absolute-img-dir)
    (make-directory absolute-img-dir :parents))

  (let* (
         (img-name
          (concat
           (make-temp-name
            (concat (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))

         (absolute-img-path (concat absolute-img-dir img-name))
         (relative-img-path (concatenate 'string "./" img-dir "/" img-name))
         (img-alt-text (read-string "Input image alt text (default empty): "))
         )

    (call-save-img-program absolute-img-path)

    (if (nth 0 date)
        (setq img-path (concat "https://raw.githubusercontent.com/" github-name "/" github-repo "/master/" img-dir "/" img-name))
      (setq img-path relative-img-path)
      )

    (insert (insert-img-path-to-buffer img-path img-alt-text))
    )
  )

(global-set-key (kbd "C-c u") 'my-org-screenshot)


(defun insert-img-path-to-buffer (file-path img-alt-text)
  "Build image file path that to insert to current point."
  (cond
   ((string-equal major-mode "markdown-mode") (format "![%s](%s)" img-alt-text file-path))
   ((string-equal major-mode "gfm-mode") (format "![%s](%s)" img-alt-text file-path))
   ((string-equal major-mode "adoc-mode") (format "image::%s[%s]\n" file-path img-alt-text))
   ((string-equal major-mode "org-mode") (progn
                                           (if (string-empty-p img-alt-text)
                                               (format "[[%s]]" file-path)
                                             (format "[[%s][%s]]" file-path img-alt-text))))
   (t (progn
        (if (string-empty-p img-alt-text)
            file-path
          (format "%s: %s" img-alt-text file-path))))))


;; parse-time-iso8601-regexp
(defconst my-parse-time-iso8601-regexp
  (let* ((dash "-?")
         (colon ":?")
         (4digit "\\([0-9][0-9][0-9][0-9]\\)")
         (2digit "\\([0-9][0-9]\\)")
         (date-fullyear 4digit)
         (date-month 2digit)
         (date-mday 2digit)
         (time-hour 2digit)
         (time-minute 2digit)
         (time-second 2digit)
         (time-secfrac "\\(\\.[0-9]+\\)?")
         (time-numoffset (concat "\\([-+]\\)" time-hour ":?" time-minute "?"))
         (partial-time (concat time-hour colon time-minute colon time-second
                               time-secfrac))
         (full-date (concat date-fullyear dash date-month dash date-mday)))
    (list (concat "^" full-date)
          (concat "T" partial-time)
          (concat "\\(Z\\|" time-numoffset "\\)")))
  "List of regular expressions matching ISO 8601 dates.
1st regular expression matches the date.
2nd regular expression matches the time.
3rd regular expression matches the (optional) timezone specification.")

(defun parse-date-string (date-string)
  "Parse a date string, such as 2016-12-01"
  (let ((date-re (nth 0 my-parse-time-iso8601-regexp)))
    (when (string-match date-re date-string)
      (let ((year  (match-string 1 date-string))
            (month (match-string 2 date-string))
            (day (match-string 3 date-string)))
        (list day month year)))))


(defun parse-time-from-buffer-file-name (buffer-file-name)
  "@stanley_110101011"
  (if-let* ((file-name (file-name-nondirectory buffer-file-name))
            (file-name (if (> (length file-name) 10) file-name))
            (date (parse-date-string (substring file-name 0 10))))
      date
    (list nil nil)))


(defun call-save-img-program (img-path)
  (cond
   ((string= system-type "darwin")
    (progn
      (call-process-shell-command "convert" nil nil nil nil (concat "\"" img-path "\" -resize  \"50%\"" ) (concat "\"" img-path "\"" ))))
   ((string= system-type "gnu/linux")
    (call-process "import" nil nil nil img-path))
   ((string= system-type "windows-nt")
    (progn
      (shell-command "snippingtool /clip")
      (shell-command (concat "powershell -command \"Add-Type -AssemblyName System.Windows.Forms;if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {$image = [System.Windows.Forms.Clipboard]::GetImage();[System.Drawing.Bitmap]$image.Save('" img-path "',[System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'clipboard content saved as file'} else {Write-Output 'clipboard does not contain image data'}\""))
      )))
  )

(provide 'init-capture-paste)
;;; init-capture-paste.el ends here
