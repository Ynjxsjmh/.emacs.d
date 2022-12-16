(require 'cdlatex)

;; copy from <https://www.emacswiki.org/emacs/AUCTeX#toc2>
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)

;; copy from <https://www.emacswiki.org/emacs/AUCTeX#toc5>
(setq TeX-PDF-mode t)
(require 'tex)
(TeX-global-PDF-mode t)

;; 将cdlatex设置为AUCtex的辅模式
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(add-hook 'latex-mode-hook 'turn-on-cdlatex)

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;;LaTeX config
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'tex-compile-commands '("xelatex --shell-escape -interaction nonstopmode -output-directory %o %f" t "%r.pdf"))
            (setq TeX-auto-untabify t  ; remove all tabs before saving
                  TeX-show-compilation t ; display compilation windows
                  TeX-save-query nil
                  TeX-engine 'xetex   ; use xelatex default
                  ;; TeX-command-default "XeLaTeX"
                  )
            (TeX-global-PDF-mode t)     ; PDF mode enable, not plain
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))


(add-hook 'LaTeX-mode-hook #'latex-extra-mode)

(setq katex-map
      '(;; Delimiters
        ("\\lparen" "(") ("\\rparen" ")") ("\\lceil"  "⌈") ("\\rceil"  "⌉") ("\\uparrow" "↑")
        ("\\lbrack" "[") ("\\rbrack" "]") ("\\lfloor" "⌊") ("\\rfloor" "⌋") ("\\downarrow" "↓")
        ("\\lbrace" "{") ("\\rbrace" "}") ("\\lmoustache" "⎰") ("\\rmoustache" "⎱") ("\\updownarrow" "↕")
        ("\\langle" "⟨") ("\\rangle" "⟩") ("\\lgroup" "⟮") ("\\rgroup" "⟯") ("\\Uparrow" "⇑")
        ("\\vert" "∣") ("\\ulcorner" "⌜") ("\\urcorner" "⌝") ("\\Downarrow" "⇓")
        ("\\|" "∥") ("\\Vert" "∥") ("\\llcorner" "⌞") ("\\lrcorner" "⌟") ("\\Updownarrow" "⇕")
        ("\\lvert" "∣") ("\\rvert" "∣") ("\\lVert" "∥") ("\\rVert" "∥") ("\\backslash" "\\")
        ("\\lang" "⟨") ("\\rang" "⟩") ("\\lt" "<") ("\\gt" ">") ("\\llbracket" "⟦") ("\\rrbracket" "⟧")

        ;; Letters and Unicode
        ;;; Greek Letters
        ("\\Alpha"   "A") ("\\Beta"  "B") ("\\Gamma"   "Γ") ("\\Delta"   "Δ")
        ("\\Epsilon" "E") ("\\Zeta"  "Z") ("\\Eta"     "H") ("\\Theta"   "Θ")
        ("\\Iota"    "I") ("\\Kappa" "K") ("\\Lambda"  "Λ") ("\\Mu"      "M")
        ("\\Nu"      "N") ("\\Xi"    "Ξ") ("\\Omicron" "O") ("\\Pi"      "Π")
        ("\\Rho"     "P") ("\\Sigma" "Σ") ("\\Tau"     "T") ("\\Upsilon" "Υ")
        ("\\Phi"     "Φ") ("\\Chi"   "X") ("\\Psi"     "Ψ") ("\\Omega"   "Ω")
        ("\\varGamma" "Γ") ("\\varDelta" "Δ") ("\\varTheta" "Θ") ("\\varLambda"  "Λ")
        ("\\varXi"    "Ξ") ("\\varPi"    "Π") ("\\varSigma" "Σ") ("\\varUpsilon" "Υ")
        ("\\varPhi"   "Φ") ("\\varPsi"   "Ψ") ("\\varOmega" "Ω")
        ("\\alpha"   "α") ("\\beta"  "β") ("\\gamma"   "γ") ("\\delta"   "δ")
        ("\\epsilon" "ϵ") ("\\zeta"  "ζ") ("\\eta"     "η") ("\\theta"   "θ")
        ("\\iota"    "ι") ("\\kappa" "κ") ("\\lambda"  "λ") ("\\mu"      "μ")
        ("\\nu"      "ν") ("\\xi"    "ξ") ("\\omicron" "ο") ("\\pi"      "π")
        ("\\rho"     "ρ") ("\\sigma" "σ") ("\\tau"     "τ") ("\\upsilon" "υ")
        ("\\phi"     "ϕ") ("\\chi"   "χ") ("\\psi"     "ψ") ("\\omega"   "ω")
        ("\\varepsilon" "ε") ("\\varkappa" "ϰ") ("\\vartheta" "ϑ") ("\\thetasym" "ϑ")
        ("\\varpi"      "ϖ") ("\\varrho"   "ϱ") ("\\varsigma" "ς") ("\\varphi"   "φ")
        ("\\digamma" "ϝ")

        ;; Logic and Set Theory
        ("\\forall"  "∀") ("\\therefore" "∴") ("\\emptyset" "∅")
        ("\\exists"  "∃") ("\\subset"    "⊂") ("\\because"  "∵")  ("\\empty"      "∅")
        ("\\exist"   "∃") ("\\supset"    "⊃") ("\\mapsto"   "↦") ("\\varnothing" "∅")
        ("\\nexists" "∄") ("\\mid"       "|") ("\\to"       "→") ("\\implies"    "⟹")
        ("\\in"      "∈") ("\\land"      "∧") ("\\gets"     "←") ("\\impliedby"  "⟸")
        ("\\isin"    "∈") ("\\lor"       "∨") ("\\leftrightarrow" "↔") ("\\iff"  "⟺")
        ("\\ni"      "∋") ("\\neg"       "¬") ("\\lnot" "¬")

        ;; Relations
        ("\\doteqdot" "≑") ("\\lessapprox" "⪅") ("\\smile" "⌣")
        ("\\eqcirc" "≖") ("\\lesseqgtr" "⋚") ("\\sqsubset" "⊏")
        ("\\eqcolon" "−:") ("\\lesseqqgtr" "⪋") ("\\sqsubseteq" "⊑")
        ("\\Eqcolon" "−::") ("\\lessgtr" "≶") ("\\sqsupset" "⊐")
        ("\\approx" "≈") ("\eqqcolon" "=:") ("\\lesssim" "≲") ("\\sqsupseteq" "⊒")
        ("\\approxcolon" "≈:") ("\\Eqqcolon" "=::") ("\\ll" "≪") ("\\Subset" "⋐")
        ("\\approxcoloncolon" "≈::") ("\\eqsim" "≂") ("\\lll" "⋘") ("\\subset" "⊂")
        ("\\approxeq" "≊") ("\\eqslantgtr" "⪖") ("\\llless" "⋘") ("\\subseteq" "⊆")
        ("\\asymp" "≍") ("\\eqslantless" "⪕") ("\\lt" "<") ("\\subseteqq" "⫅")
        ("\\backepsilon" "∍") ("\\equiv" "≡") ("\\mid" "∣") ("\\succ" "≻")
        ("\\backsim" "∽") ("\\fallingdotseq" "≒") ("\\models" "⊨") ("\\succapprox" "⪸")
        ("\\backsimeq" "⋍") ("\\frown" "⌢") ("\\multimap" "⊸") ("\\succcurlyeq" "≽")
        ("\\between" "≬") ("\\ge" "≥") ("\\origof" "⊶") ("\\succeq" "⪰")
        ("\\bowtie" "⋈") ("\\geq" "≥") ("\\owns" "∋") ("\\succsim" "≿")
        ("\\bumpeq" "≏") ("\\geqq" "≧") ("\\parallel" "∥") ("\\Supset" "⋑")
        ("\\Bumpeq" "≎") ("\\geqslant" "⩾") ("\\perp" "⊥") ("\\supset" "⊃")
        ("\\circeq" "≗") ("\\gg" "≫") ("\\pitchfork" "⋔") ("\\supseteq" "⊇")
        ("\\colonapprox" ":≈") ("\\ggg" "⋙") ("\\prec" "≺") ("\\supseteqq" "⫆")
        ("\\Colonapprox" "::≈") ("\\gggtr" "⋙") ("\\precapprox" "⪷") ("\\thickapprox" "≈")
        ("\\coloneq" ":−") ("\\gt" ">") ("\\preccurlyeq" "≼") ("\\thicksim" "∼")
        ("\\Coloneq" "::−") ("\\gtrapprox" "⪆") ("\\preceq" "⪯") ("\\trianglelefteq" "⊴")
        ("\\coloneqq" ":=") ("\\gtreqless" "⋛") ("\\precsim" "≾") ("\\triangleq" "≜")
        ("\\Coloneqq" "::=") ("\\gtreqqless" "⪌") ("\\propto" "∝") ("\\trianglerighteq" "⊵")
        ("\\colonsim" ":∼") ("\\gtrless" "≷") ("\\risingdotseq" "≓") ("\\varpropto" "∝")
        ("\\Colonsim" "::∼") ("\\gtrsim" "≳") ("\\shortmid" "∣") ("\\vartriangle" "△")
        ("\\cong" "≅") ("\\imageof" "⊷") ("\\shortparallel" "∥") ("\\vartriangleleft" "⊲")
        ("\\curlyeqprec" "⋞") ("\\in" "∈") ("\\sim" "∼") ("\\vartriangleright" "⊳")
        ("\\curlyeqsucc" "⋟") ("\\Join" "⋈") ("\\simcolon" "∼:") ("\\vcentcolon" ":")
        ("\\dashv" "⊣") ("\\le" "≤") ("\\simcoloncolon" "∼::") ("\\vdash" "⊢")
        ("\\dblcolon" "::") ("\\leq" "≤") ("\\simeq" "≃") ("\\vDash" "⊨")
        ("\\doteq" "≐") ("\\leqq" "≦") ("\\smallfrown" "⌢") ("\\Vdash" "⊩")
        ("\\Doteq" "≑") ("\\leqslant" "⩽") ("\\smallsmile" "⌣") ("\\Vvdash" "⊪")

        ;;; Negated Relations
        ("\\gnapprox" "⪊") ("\\ngeqslant" "") ("\\nsubseteq" "⊈") ("\\precneqq" "⪵")
        ("\\gneq" "⪈") ("\\ngtr" "≯") ("\\nsubseteqq" "") ("\\precnsim" "⋨") ("\\gneqq" "≩")
        ("\\nleq" "≰") ("\\nsucc" "⊁") ("\\subsetneq" "⊊") ("\\gnsim" "⋧") ("\\nleqq" "")
        ("\\nsucceq" "⋡") ("\\subsetneqq" "⫋") ("\\gvertneqq" "") ("\\nleqslant" "")
        ("\\nsupseteq" "⊉") ("\\succnapprox" "⪺") ("\\lnapprox" "⪉") ("\\nless" "≮")
        ("\\nsupseteqq" "") ("\\succneqq" "⪶") ("\\lneq" "⪇") ("\\nmid" "∤")
        ("\\ntriangleleft" "⋪") ("\\succnsim" "⋩") ("\\lneqq" "≨") ("\\notin" "∈/")
        ("\\ntrianglelefteq" "⋬") ("\\supsetneq" "⊋") ("\\lnsim" "⋦") ("\\notni" "")
        ("\\ntriangleright" "⋫") ("\\supsetneqq" "⫌") ("\\lvertneqq" "") ("\\nparallel" "∦")
        ("\\ntrianglerighteq" "⋭") ("\\varsubsetneq" "") ("\\ncong" "≆") ("\\nprec" "⊀")
        ("\\nvdash" "⊬") ("\\varsubsetneqq" "") ("\\ne" "=") ("\\npreceq" "⋠")
        ("\\nvDash" "⊭") ("\\varsupsetneq" "") ("\\neq" "=") ("\\nshortmid" "")
        ("\\nVDash" "⊯") ("\\varsupsetneqq" "") ("\\ngeq" "≱") ("\\nshortparallel" "")
        ("\\nVdash" "⊮") ("\\ngeqq" "") ("\\nsim" "≁") ("\\precnapprox" "⪹")

        ;;; Arrows
        ("\\circlearrowleft" "↺") ("\\leftharpoonup" "↼") ("\\rArr" "⇒")
        ("\\circlearrowright" "↻") ("\\leftleftarrows" "⇇") ("\\rarr" "→")
        ("\\curvearrowleft" "↶") ("\\leftrightarrow" "↔") ("\\restriction" "↾")
        ("\\curvearrowright" "↷") ("\\Leftrightarrow" "⇔") ("\\rightarrow" "→")
        ("\\Darr" "⇓") ("\\leftrightarrows" "⇆") ("\\Rightarrow" "⇒") ("\\dArr" "⇓")
        ("\\leftrightharpoons" "⇋") ("\\rightarrowtail" "↣") ("\\darr" "↓")
        ("\\leftrightsquigarrow" "↭") ("\\rightharpoondown" "⇁") ("\\dashleftarrow" "⇠")
        ("\\Lleftarrow" "⇚") ("\\rightharpoonup" "⇀") ("\\dashrightarrow" "⇢")
        ("\\longleftarrow" "⟵") ("\\rightleftarrows" "⇄") ("\\downarrow" "↓")
        ("\\Longleftarrow" "⟸") ("\\rightleftharpoons" "⇌") ("\\Downarrow" "⇓")
        ("\\longleftrightarrow" "⟷") ("\\rightrightarrows" "⇉") ("\\downdownarrows" "⇊")
        ("\\Longleftrightarrow" "⟺") ("\\rightsquigarrow" "⇝") ("\\downharpoonleft" "⇃")
        ("\\longmapsto" "⟼") ("\\Rrightarrow" "⇛") ("\\downharpoonright" "⇂")
        ("\\longrightarrow" "⟶") ("\\Rsh" "↱") ("\\gets" "←") ("\\Longrightarrow" "⟹")
        ("\\searrow" "↘") ("\\Harr" "⇔") ("\\looparrowleft" "↫") ("\\swarrow" "↙")
        ("\\hArr" "⇔") ("\\looparrowright" "↬") ("\\to" "→") ("\\harr" "↔")
        ("\\Lrarr" "⇔") ("\\twoheadleftarrow" "↞") ("\\hookleftarrow" "↩") ("\\lrArr" "⇔")
        ("\\twoheadrightarrow" "↠") ("\\hookrightarrow" "↪") ("\\lrarr" "↔") ("\\Uarr" "⇑")
        ("\\iff" "⟺") ("\\Lsh" "↰") ("\\uArr" "⇑") ("\\impliedby" "⟸") ("\\mapsto" "↦")
        ("\\uarr" "↑") ("\\implies" "⟹") ("\\nearrow" "↗") ("\\uparrow" "↑") ("\\Larr" "⇐")
        ("\\nleftarrow" "↚") ("\\Uparrow" "⇑") ("\\lArr" "⇐") ("\\nLeftarrow" "⇍")
        ("\\updownarrow" "↕") ("\\larr" "←") ("\\nleftrightarrow" "↮") ("\\Updownarrow" "⇕")
        ("\\leadsto" "⇝") ("\\nLeftrightarrow" "⇎") ("\\upharpoonleft" "↿") ("\\leftarrow" "←")
        ("\\nrightarrow" "↛") ("\\upharpoonright" "↾") ("\\Leftarrow" "⇐") ("\\nRightarrow" "⇏")
        ("\\upuparrows" "⇈") ("\\leftarrowtail" "↢") ("\\nwarrow" "↖") ("\\leftharpoondown" "↽")
        ("\\Rarr" "⇒")))

;; var cells = document.getElementsByTagName('table')[8].getElementsByTagName('td');
;; for (var cell of cells) {
;;   var latex = cell.getElementsByTagName('code')[0];
;;   var text = cell.querySelectorAll('.mord,.mrel')[0];
;;   if (latex === undefined || text === undefined) {
;;     continue;
;;   }
;;   console.log(`("\\${latex.textContent}" "${text.textContent}")`);
;; }

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
