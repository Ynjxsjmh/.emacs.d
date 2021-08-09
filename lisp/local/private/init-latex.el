;;LaTeX config
(add-hook 'LaTeX-mode-hook
        (lambda ()
          (add-to-list 'tex-compile-commands '("xelatex --shell-escape -interaction nonstopmode -output-directory %o %f" t "%r.pdf"))
          (setq TeX-auto-untabify t     ; remove all tabs before saving
                TeX-show-compilation t  ; display compilation windows
                TeX-save-query nil
                TeX-engine 'xetex       ; use xelatex default
                ;; TeX-command-default "XeLaTeX"
                )
          (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
          (imenu-add-menubar-index)
          (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))


(add-hook 'LaTeX-mode-hook #'latex-extra-mode)


(setq superscript-subscript-map
      ;;     sup sub
      '(("a" "ᵃ" "ₐ") ("b" "ᵇ" nil) ("c" "ᶜ" nil) ("d" "ᵈ" nil)
        ("e" "ᵉ" "ₑ") ("f" "ᶠ" nil) ("g" "ᵍ" nil) ("h" "ʰ" "ₕ")
        ("i" "ⁱ" "ᵢ") ("j" "ʲ" "ⱼ") ("k" "ᵏ" "ₖ") ("l" "ˡ" "ₗ")
        ("m" "ᵐ" "ₘ") ("n" "ⁿ" "ₙ") ("o" "ᵒ" "ₒ") ("p" "ᵖ" "ₚ")
        ("q" nil nil) ("r" "ʳ" "ᵣ") ("s" "ˢ" "ₛ") ("t" "ᵗ" "ₜ")
        ("u" "ᵘ" "ᵤ") ("v" "ᵛ" "ᵥ") ("w" "ʷ" nil) ("x" "ˣ" "ₓ")
        ("y" "ʸ" nil) ("z" "ᶻ" nil)
        ("A" "ᴬ" nil) ("B" "ᴮ" nil) ("C" nil nil) ("D" "ᴰ" nil)
        ("E" "ᴱ" nil) ("F" nil nil) ("G" "ᴳ" nil) ("H" "ᴴ" nil)
        ("I" "ᴵ" nil) ("J" "ᴶ" nil) ("K" "ᴷ" nil) ("L" "ᴸ" nil)
        ("M" "ᴹ" nil) ("N" "ᴺ" nil) ("O" "ᴼ" nil) ("P" "ᴾ" nil)
        ("Q" nil nil) ("R" "ᴿ" nil) ("S" nil nil) ("T" "ᵀ" nil)
        ("U" "ᵁ" nil) ("V" "ⱽ" nil) ("W" "ᵂ" nil) ("X" nil nil)
        ("Y" " " nil) ("Z" " " nil)
        ("0" "⁰" "₀") ("1" "¹" "₁") ("2" "²" "₂") ("3" "³" "₃")
        ("4" "⁴" "₄") ("5" "⁵" "₅") ("6" "⁶" "₆") ("7" "⁷" "₇")
        ("8" "⁸" "₈") ("9" "⁹" "₉")
        ("+" "⁺" "₊") ("-" "⁻" "₋") ("=" "⁼" "₌") ("(" "⁽" "₍")
        (")" "⁾" "₎")
        ("ɑ" "ᵅ" nil) ("β" "ᵝ" "ᵦ") ("θ" "ᶿ" nil)))

(defun convert-to-unicode (str subsup)
  (let ((converted-str ""))
    (progn
      (dolist (c (delete "" (split-string str "")))
        (cond ((string-equal subsup "^")
               (setq converted-str (concat converted-str (nth 0 (cdr (assoc c superscript-subscript-map))))))
              ((string-equal subsup "_")
               (setq converted-str (concat converted-str (nth 1 (cdr (assoc c superscript-subscript-map))))))
              (t "default")))
      (if (eq (length str) (length converted-str))
          converted-str))))

(defun latex-to-unicode ()
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "\\([_^]\\){\\([[:word:]ɑβθ+-=()]+\\)}" nil t)
    (let ((data (match-data)))
      (unwind-protect
          (setq converted-str (convert-to-unicode (match-string 2) (match-string 1)))
        (set-match-data data)))
    (if converted-str
        (replace-match converted-str))))


(provide 'init-latex)
