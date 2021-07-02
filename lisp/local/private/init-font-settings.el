;; -*- lexical-binding: t -*-

;; This is from https://chriszheng.science/2015/04/26/Emacs-font-settings/
;; Font settings.

;; Setting English Font
(add-to-list 'default-frame-alist '(height . 35))
(add-to-list 'default-frame-alist '(width . 100))
;; (add-to-list 'default-frame-alist
;;              (if (string-equal system-type "windows-nt")
;;       '(font . "Inconsolata-18")
;;         '(font . "Inconsolata-14")))

;; 微软雅黑
;; 冬青黑体简体中文 W3
;; Hiragino Sans GB W3
;; 思源黑体 CN Regular
;; Source Han Sans

;; Old comments:
;; (set-fontset-font t
;;            'unicode (font-spec :family "Inconsolata" :size 18))
;; Chinese Font
;; cjk-misc gb18030 chinese-gbk chinese-gb2312
;; (set-fontset-font t
;;          'unicode (font-spec :name "Inconsolata" :size 28))

(defun my--set-font (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (if (string-equal system-type "windows-nt")
        ;; 下面是用于Windows的配置。
        (progn
          ;; 设置英文字体为Inconsolata，并指定字号16。
          ;; 因为不同操作系统下字体显示的大小不一样(DPI的问题)，所以分开设置。
          (set-face-attribute 'default nil :font "Inconsolata 16")

          ;; (add-to-list 'default-frame-alist
          ;;              '(font . "Inconsolata 16"))
          ;; (set-fontset-font "fontset-startup"
          ;;                   'ascii (font-spec :family "Inconsolata" :size 24) nil 'prepend)

          ;; 给相应的字符集设置中文字体，这里的字体是冬青黑体简体中文 W3。
          (dolist (charset '(han cjk-misc chinese-gbk))
            (set-fontset-font "fontset-default"
                              charset (font-spec :family "冬青黑体简体中文 W3")))

          ;; Emacs 25.2之后的版本无法单独设置符号的字体，这句禁用这个特性恢复原来的行为。
          (setq use-default-font-for-symbols nil)

          ;; 设置默认字体和用于显示特殊符号的字体，如果不需要下面三句可以删除。
          (set-fontset-font "fontset-default"
                            'unicode "Segoe UI Symbol" nil 'append)
          (set-fontset-font "fontset-default"
                            '(#x1F600 . #x1F64F) "Segoe UI Symbol") ; Emoji
          (set-fontset-font "fontset-default"
                            '(#xE000 . #xF8FF) "STIX")) ; Private Use Areas

      ;; 下面是Linux的配置，道理类似。
      (set-face-attribute 'default nil :font "Inconsolata 16")
      (dolist (charset '(kana han cjk-misc bopomofo))
        (set-fontset-font "fontset-default"
                          charset (font-spec :name "Hiragino Sans GB")))))

  ;; 对于特定的符号设置字体，不分操作系统。我的个人爱好，可以删除。
  (set-fontset-font "fontset-default" '(#x2010 . #x2017) "Symbola") ;; – —
  (set-fontset-font "fontset-default" '(#x2032 . #x2037) "Symbola") ;; ′ ″ ‴ ‵ ‶ ‷

  (set-fontset-font "fontset-default" '(#x2018 . #x2019) "Inconsolata") ;; ‘’
  (set-fontset-font "fontset-default" '(#x201c . #x201d) "Inconsolata") ;; “”
  (set-fontset-font "fontset-default" ?− "Inconsolata") ;; −
  )

;; 运行一下立即设置字体。
;; (add-hook 'after-init-hook 'my--set-font)
(my--set-font)

;; 对于新建的frame应用设置。
(add-hook 'after-make-frame-functions #'my--set-font)

(defface strike-through
  '((t :strike-through t))
  "Basic strike through face."
  :group 'basic-faces)

(provide 'init-font-settings)