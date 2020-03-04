;;; https://emacs-china.org/t/topic/7687
;;; whitespace-killer --- 删除多余的空白字符
;;; Commentary:
;;; 删除行尾空白字符但不删除 Markdown 格式的行尾空白字符
;;;
;;; TODO Markdown 删除非行尾的单行空白字符
;;;
;;; Code:

;; https://www.emacswiki.org/emacs/DeletingWhitespace#toc13
(defun whitespace-killer-delete-end-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file."
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines))))

;; https://www.emacswiki.org/emacs/auto-save.el
(defun whitespace-killer-delete-trailing-whitespace-except-current-line ()
  "Delete trailing whitespace except current line."
  (interactive)
  (let ((begin (line-beginning-position))
        (end (line-end-position)))
    (save-excursion
      (when (< (point-min) begin)
        (save-restriction
          (narrow-to-region (point-min) (1- begin))
          (delete-trailing-whitespace)))
      (when (> (point-max) end)
        (save-restriction
          (narrow-to-region (1+ end) (point-max))
          (delete-trailing-whitespace))))))

(defun kill-whitespace ()
  "Kill whitespace."
  (interactive)
  (if (derived-mode-p 'markdown-mode)
      (whitespace-killer-delete-end-trailing-blank-lines)
    (whitespace-killer-delete-trailing-whitespace-except-current-line)))

(provide 'init-whitespace-killer)
;;; init-whitespace-killer.el ends here
