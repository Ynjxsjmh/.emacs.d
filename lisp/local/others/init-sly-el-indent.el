(require 'sly-el-indent)

(add-hook 'emacs-lisp-hook
            (function sly-el-indent-setup))

(provide 'init-sly-el-indent)
;;; init-sly-el-indent.el ends here