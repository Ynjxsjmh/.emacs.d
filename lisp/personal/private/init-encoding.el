;; Emacs 中的编码都是 utf-8，Windows 默认编码是 GBK

;;设置默认读入文件编码
(prefer-coding-system 'utf-8)
;;设置写入文件编码
(setq default-buffer-file-coding-system 'utf-8)

;; 文件名使用GBK编码
;; (setq file-name-coding-system 'utf-8)

;; https://www.zhihu.com/question/29369444/answer/44730639
;; 设置语系变量
;; (when (string-equal system-type "windows-nt")
;;   (setenv "LANG" "zh_CN.GBK")
;;   (setenv "LC_COLLATE" "zh_CN.GBK")
;;   (setenv "LC_CTYPE" "zh_CN.GBK")
;;   (setenv "LC_MESSAGES" "zh_CN.GBK")
;;   (setenv "LC_MONETARY" "zh_CN.GBK")
;;   (setenv "LC_NUMERIC" "zh_CN.GBK")
;;   (setenv "LC_TIME" "zh_CN.GBK"))

;; https://chriszheng.science/2015/09/24/Prefer-UTF-8-in-MS-Windows/
;; https://emacs-china.org/t/topic/3894/23
;; Emacs 可以单独对某一个进程设置编码，把它内部关于编码的处理机制搞明白就能得心应手了。
;; 这些进程是指与 Emacs 有交互的进程。
;; 最普遍的场景就是在 Emacs 中给某一个进程传递参数，然后把这个进程的运行结果读取到 Emacs 的 buffer 中。
;; 其中传递参数和读取运行结果都会有相应的编码处理过程。
;; 以下是对几个进程的编码设置，其他关于编码的设置保持默认。
;; 如：“[rR][gG]” 匹配 “rg” 进程名称的正则表达式。
;; M-x describe-variable process-coding-system-alist 查看参数说明
;;
;; Alist to decide a coding system to use for a process I/O operation.
;; The format is ((PATTERN . VAL) ...),
;; where PATTERN is a regular expression matching a program name,
;; If VAL is a cons of coding systems, the car part is used for decoding,
;; and the cdr part is used for encoding.

(when (eq system-type 'windows-nt)
 (set-default 'process-coding-system-alist
   		   '(("[pP][lL][iI][nN][kK]" gbk-dos . gbk-dos)
   			 ("[cC][mM][dD][pP][rR][oO][xX][yY]" utf-8-dos . gbk-dos)
   			 ("[rR][gG]" utf-8-dos . gbk-dos)
   			 ("[gG][iI][tT]" utf-8-dos . gbk-dos)
   			 ("[gG][rR][eE][pP]" utf-8-dos . gbk-dos)
   			 ("[uU][nN][zZ][iI][pP]" gbk-dos . gbk-dos)
   			 )))

;; (with-eval-after-load "nov"
;;   (when (string-equal system-type "windows-nt")
;;     (setq process-coding-system-alist
;;           (cons `(,nov-unzip-program . (gbk . gbk))
;;                 process-coding-system-alist))))

(provide 'init-encoding)