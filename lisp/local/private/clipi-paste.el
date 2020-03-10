;;; clipi-paste.el --- Save clipboard image to disk file, and insert file link to current point.

;; Filename: clipi-paste.el
;; Description: Save clipboard image to disk file, and insert file link to current point.
;; Author: Ynjxsjmh <ynjxsjmh@gmail.com>
;; Maintainer: Ynjxsjmh <ynjxsjmh@gmail.com>
;; Copyright (C) 2020, Ynjxsmh, all rights reserved.
;; Created: 2020-03-05 03:23
;; Version: 0.1
;; Last-Updated: <2020-03-10 Tue 23:09>
;;           By: Ynjxsjmh

;; Keywords:
;; Compatibility: GNU Emacs 25.3
;;
;; Features that might be required by this library:
;;
;;
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Save clipboard image to disk file, and insert file link to current point.
;;
;; It's an Emacs extension, with it you can just use one key to save clipboard
;; image to disk file, and at the same time insert the file link(org-mode/markdown-mode/adoc-mode)
;; or file path(other mode) to current point.

;;; Acknowledgements:
;; dnxbjyj/pasteex-mode
;;
;;

;;; TODO
;;
;;
;;

;;; Require


;;; Code:


(defvar github-name "Ynjxsjmh")
(defvar github-repo "ynjxsjmh.github.io")

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
   same directory as the org-buffer and insert a link to this file."
  (interactive)

  (setq date (parse-time-from-buffer-file-name (buffer-file-name)))

  (if (nth 0 date)
      (setq img-dir (concat "img/" (nth 2 date) "/" (nth 1 date)))
    (setq img-dir "images"))

  (setq absolute-img-dir (concatenate 'string
                                      (file-name-directory (buffer-file-name))
                                      (format "%s/" img-dir)))

  (unless (file-directory-p absolute-img-dir)
    (make-directory absolute-img-dir :parents))

  (let* (
         (input-img-name (read-string "Input image name (default current timestamp): "))
         (img-name (if (string= "" input-img-name)
                       (concat (make-temp-name (concat (format-time-string "%Y%m%d_%H%M%S_")) ) ".png")
                     (concat input-img-name ".png")))

         (absolute-img-path (concat absolute-img-dir img-name))
         (relative-img-path (concatenate 'string "./" img-dir "/" img-name))
         (img-alt-text (read-string "Input image alt text (default empty): "))
         )

    (call-save-img-program absolute-img-path)

    (let* ((img-path (if (nth 0 date)
                         (concat "https://raw.githubusercontent.com/" github-name "/" github-repo "/master/" img-dir "/" img-name)
                       relative-img-path
                       )))

      (insert (insert-img-path-to-buffer img-path img-alt-text))
      )
    )
  )

(global-set-key (kbd "C-c i i") 'my-org-screenshot)


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

(provide 'clipi-paste)
;;; clipi-paste ends here
