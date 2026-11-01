;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values
   '((eval load-theme 'doom-solarized-light t)
     (org-emphasis-alist ("*" bold) ("/" (:foreground "red")) ("_" underline)
      ("=" (:foreground "dark green" :inherit org-verbativ) verbatim)
      ("~" (:foreground "orange" :inherit org-code) verbatim)
      ("+" (:strike-through t)))))
 '(package-selected-packages '(doom-themes reverse-im))
 '(safe-local-variable-values
   '((org-html-text-markup-alist (bold . "<b>%s</b>")
      (code . "<code class=\"code\">%s</code>") (italic . "<i>%s</i>")
      (strike-through . "<del>%s</del>")
      (underline . "<span class=\"underline\">%s</span>")
      (verbatim . "<code class=\"verbatim\">%s</code>"))
     (org-highlight-links)
     (org-emphasis-alist ("*" bold) ("/" (:foreground "red")) ("_" underline)
      ("=" (:foreground "green4" :inherit org-verbativ) verbatim)
      ("~" (:foreground "orange3" :inherit org-verbativ) verbatim)
      ("+" (:strike-through t)))
     (org-emphasis-alist ("*" bold) ("/" (:foreground "red")) ("_" underline)
      ("=" org-verbatim verbatim) ("~" org-code verbatim)
      ("+" (:strike-through t))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))
