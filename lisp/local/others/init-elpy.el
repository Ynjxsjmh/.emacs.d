
;; https://www.reddit.com/r/emacs/comments/e1y1yk/utf8_encoding_on_windows/f9j9i3w
;; Fix elpy error
;; error in process sentinel: elpy-rpc--default-error-callback: peculiar error: "exited abnormally with code 1"
;; error in process sentinel: peculiar error: "exited abnormally with code 1"

(setenv "PYTHONIOENCODING" "utf-8")
(add-to-list 'process-coding-system-alist '("elpy" . (utf-8 . utf-8)))
(add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
(add-to-list 'process-coding-system-alist '("flake8" . (utf-8 . utf-8)))

(provide 'init-elpy)
;; init-elpy.el ends here
