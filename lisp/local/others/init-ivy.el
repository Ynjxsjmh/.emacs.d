(require 'ivy)

;; https://github.com/raxod502/prescient.el/issues/43#issuecomment-523459648
;; First, ivy-prescient-re-builder is assigned for counsel-rg.
(ivy-prescient-mode 1)
;; Second, overwrite ivy-prescient-re-builder by ivy--regex-plus
(setf (alist-get 'counsel-rg ivy-re-builders-alist) #'ivy--regex-plus)

(provide 'init-ivy.el)