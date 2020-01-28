;; -*- lexical-binding: t -*-

(require 'hydra)
(require 'web-mode)

(setq div_open_regex "<div.*>")
(setq div_close_regex "</div>")

(setq p_open_regex "<p.*>")
(setq p_close_regex "</p>")

(setq h_open_regex "<h\\([12345]\\)>")
(setq h_close_regex "</h[12345]>")

(setq a_regex "<a.*href=.*>(.*?)</a>")

(setq b_regex "</?b>")
(setq em_regex "</?em>")
(setq del_regex "</?del>")

(setq code_regex "</?code>")
(setq pre_open_regex "<pre>")

(setq hr_regex "<hr>.*</hr>")

(defun buffer-content ()
  (buffer-substring-no-properties (point-min) (point-max) )
  )

(defun my-convert-html-to-markdown ()
  "Convert html to markdown."
  (interactive)

  (setq content (buffer-content))

  (setq content (replace-regexp-in-string div_open_regex "" content))
  (setq content (replace-regexp-in-string div_close_regex "\n" content))

  (setq content (replace-regexp-in-string p_open_regex "" content))
  (setq content (replace-regexp-in-string p_close_regex "\n" content))

  (setq content (replace-regexp-in-string h_open_regex (concat (make-string (string-to-number "\\1") ?#) " ") content))
  (setq content (replace-regexp-in-string h_close_regex "\n" content))

  (setq content (replace-regexp-in-string b_regex "**" content))
  (setq content (replace-regexp-in-string em_regex "_" content))
  (setq content (replace-regexp-in-string del_regex "~~" content))

  (setq content (replace-regexp-in-string code_regex "`" content))

  (setq content (replace-regexp-in-string hr_regex "___\n" content))

  (print content)
)

(defun get_output_name (extension)
  (setq file_name buffer-file-name)
  (setq file_name_list (split-string file_name "\\."))
  (setq file_name_list (butlast file_name_list))
  (setq file_name_list (append file_name_list (list extension)))
  (setq file_name (string-join file_name_list "."))
  )

(defun convert-html-to-markdown ()
  (interactive)
  (shell-command (format "pandoc -f html -t markdown_strict \"%s\" -o \"%s\"" buffer-file-name (get_output_name "md")))
  )

(defun convert-html-to-asciidoc ()
  (interactive)
  (shell-command (format "pandoc -f html -t asciidoc \"%s\" -o \"%s\"" buffer-file-name (get_output_name "adoc")))
  )


(defhydra hydra-html (:color pink)
  "
_m_ Export to Markdown
_a_ Export to AsciiDoc
"
  ("m" convert-html-to-markdown nil :exit t)
  ("a" convert-html-to-asciidoc nil :exit t)
  ("q" nil "quit"))

(define-key web-mode-map (kbd "C-c C-e") 'hydra-html/body)

(provide 'init-html-converter)

;;; init-html-converter.el ends here