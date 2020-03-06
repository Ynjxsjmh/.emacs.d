(require 'py-autopep8)

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq py-autopep8-options '("--max-line-length=100"))

(provide 'init-py-autopep8)