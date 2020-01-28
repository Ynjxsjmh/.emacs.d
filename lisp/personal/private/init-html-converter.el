;; -*- lexical-binding: t -*-

(require 'hydra)
(require 'web-mode)

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