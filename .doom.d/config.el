;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private confes and snippets. It is optional.
(setq user-full-name "Mikhail Pisegov"
      user-mail-address "pisegov.mikhail@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-monokai-pro)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Notes/Org-base")

;; Swap keys behaviour on mac os
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ================================================================================================================================================

;; Mapping example
;; (map! :leader
;;       (:prefix ("d" . "custom keymap")
;;                :desc "Something interesting"
;;                "e" #'org-html-export-to-html))

;; Moving by visual lines
(map! :nv "j" #'evil-next-visual-line)
(map! :nv "k" #'evil-previous-visual-line)

;; Better moving on normal and visual mode
(map! :nv "K" #'evil-backward-paragraph)
(map! :nv "J" #'evil-forward-paragraph)
(map! :nv "H" #'evil-first-non-blank)
(map! :nv "L" #'evil-end-of-line)

;; Moving inside the insert mode
(map! :i "C-k" #'evil-previous-visual-line)
(map! :i "C-j" #'evil-next-visual-line)
(map! :i "C-h" #'evil-backward-char)
(map! :i "C-l" #'evil-forward-char)

;; Moving around split windows
(map! :n "C-k" #'evil-window-up)
(map! :n "C-j" #'evil-window-down)
(map! :n "C-h" #'evil-window-left)
(map! :n "C-l" #'evil-window-right)

;; Resizing split windows
(map! :n "C-S-k" #'evil-window-increase-height)
(map! :n "C-S-j" #'evil-window-decrease-height)
(map! :n "C-S-h" #'evil-window-decrease-width)
(map! :n "C-S-l" #'evil-window-increase-width)

;; Commenting lines
(map! :nvi "C-/" #'evilnc-comment-or-uncomment-lines)

;; Ctrl-V as paste in insert mode
(map! :vi "C-v" #'evil-paste-after)

;; Font resize
;; (map! :nvi "C-=" (doom/reset-font-size))
;; (map! :nvi "C-+" (text-scale-increase 2))


;; Better russian language integration
(use-package evil-xkbswitch)
        :custom
        (evil-xkbswitch-mode t)

;; (setq evil-xkbswitch-set-layout "hyprskl")
;; (setq evil-xkbswitch-get-layout "hyprskl")
(setq evil-xkbswitch-set-layout "xkb-switch -s")
(setq evil-xkbswitch-get-layout "xkb-switch")

(use-package char-fold
  :custom
  (char-fold-symmetric t)
  (search-default-mode #'char-fold-to-regexp))
(use-package reverse-im
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :custom
  (reverse-im-char-fold t) ; use lax matching
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  (reverse-im-input-methods '("russian-computer")) ; translate these methods
  :config
  (reverse-im-mode t)) ; turn the mode on

;; Paste the same text multiple times in visual mode
;; https://discourse.doomemacs.org/t/fixing-vi-paste-for-us-plebs/2779
(setq evil-kill-on-visual-paste nil)

;; LaTeX
;; Set xelatex as the default latex compiler
(setq TeX-engine 'xetex)
(setq TeX-PDF-mode t)
(setq pdf-latex-command "xelatex")

;; C++
(after! ccls
  (setq ccls-executable "/home/pmikhail/programs/custom-shell-scripts/ccls-executor")
  (set-lsp-priority! 'ccls 0))


;; Telegram client
;; (setq telega-use-docker t)
;; (setq telega-server-libs-prefix "/usr/include/treedec")

(defun my/set-auto-compilation-latex ()
  (add-hook 'after-save-hook 'TeX-command-master nil 'local ))
  ;; (add-hook 'after-save-hook (lambda () (LaTeX-command-run-all-section)) nil 'local ))
  ;; (add-hook 'after-save-hook (lambda () (TeX-command-run-all nil)) nil 'local ))
;; (add-hook 'LaTeX-mode-hook 'my/set-auto-compilation-latex)
(add-hook 'LaTeX-mode-hook 'my/set-auto-compilation-latex)


;; Writeroom
(add-hook 'text-mode-hook  (lambda () (writeroom-mode))) ;; as a lambda usage example
(add-hook 'prog-mode-hook 'writeroom-mode)
(add-hook 'conf-mode-hook 'writeroom-mode)
(add-hook 'org-mode-hook 'writeroom-mode)
(add-hook 'org-mode-hook (lambda ()
                            (setq paragraph-start "^\n"
                                 paragraph-separate "[  ]*$")))
                          ;; (setq paragraph-start "\\|[  ]*$"
;;        paragraph-separate "[  ]*$")))

(add-hook! 'android-mode 'lsp)
;; (defun execute-shell-after-save () shell-command "ls")

;; (add-hook 'after-save-hook (run-hooks 'after-save-hooks-list))

;; (add-hook 'latex-mode-hook (setq after-save-hooks-list 'execute-shell-after-save))
;;           (add-hook 'after-save-hook (shell-command "pdflatex %")))


  ;; (setq delete-by-moving-to-trash t)
  (setq trash-directory "~/.trash")
  (setq dired-listing-switches
        "-ahl -v --group-directories-first")

;; Dired configuration
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Dired view file" "d v" #'dired-view-file
        :desc "Yank file name" "y n" #'dired-copy-filenamecopy-filename-as-kill
        :desc "Yank file path" "y p" #'my-put-file-name-on-clipboard
        :desc "Abort changes" "d a" #'wdired-abort-changes)))


;; Default values for demo purposes
(setq dired-preview-delay 0)
(setq dired-preview-max-size (expt 2 20))
(setq dired-preview-ignored-extensions-regexp
      (concat "\\."
              ;; "\\(mkv\\|webm\\|mp4\\|mp3\\|ogg\\|m4a"
              "\\(mkv\\|webm\\|mp4\\|mp3\\|ogg\\|m4a"
              "\\|gz\\|zst\\|tar\\|xz\\|rar\\|zip"
              "\\|iso\\|epub\\|pdf\\)"))

;; Enable `dired-preview-mode' in a given Dired buffer or do it
;; globally:
(add-hook 'dired-mode-hook 'dired-preview-mode)

(defun my-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "RET") 'dired-open-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.

  (kbd "m") 'dired-mark
  (kbd "c") 'dired-ranger-copy
  (kbd "p") 'dired-ranger-paste
  (kbd "P") 'dired-ranger-move
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-compress-to
  (kbd "d") 'move-file-to-trash
  (kbd "D") 'dired-do-delete
  ;; (kbd "J") 'dired-goto-file
;;   (kbd "M") 'dired-do-chmod
;;   (kbd "O") 'dired-do-chown
;;   (kbd "R") 'dired-do-rename
;;   (kbd "T") 'dired-do-touch
;;   (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
;;   (kbd "Z") 'dired-do-compress
;;   (kbd "+") 'dired-create-directory
;;   (kbd "-") 'dired-do-kill-lines
;;   (kbd "% l") 'dired-downcase
;;   (kbd "% m") 'dired-mark-files-regexp
;;   (kbd "% u") 'dired-upcase
;;   (kbd "* %") 'dired-mark-files-regexp
;;   (kbd "* .") 'dired-mark-extension
;;   (kbd "* /") 'dired-mark-directories
;;   (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp3" . "mpv")
                              ("mp4" . "mpv")))


;; Python lsp server
(use-package! lsp-pyright
  ;; :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred


;; Markdown
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

;; Mouse support for terminal version of Emacs
(xterm-mouse-mode 1)

;; Fonts
;; (set-face-attribute 'default nil
;;   :font "Source Code Pro"
;;   :height 110
;;   :weight 'medium)
;; (set-face-attribute 'variable-pitch nil
;;   ;; :font "Ubuntu Nerd Font"
;;   ;; :font "MesloLGS NF"
;;   ;; :font "PT Sans"
;;   :font "Arial"
;;   :height 100
;;   ;; :weight 'medium
;;   )
;; (set-face-attribute 'fixed-pitch nil
;;   :font "Source Code Pro"
;;   :height 110
;;   :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
;; (set-face-attribute 'font-lock-comment-face nil
;;   :slant 'italic)
;; (set-face-attribute 'font-lock-keyword-face nil
;;   :slant 'italic)

;; Uncomment the following line if line spacing needs adjusting.
;; (setq-default line-spacing 0.12)

;; Needed if using emacsclient. Otherwise, your fonts will be smaller than expected.
;; (add-to-list 'default-frame-alist '(font . "Source Code Pro-11"))
;; changes certain keywords to symbols, such as lamda!
;; (setq global-prettify-symbols-mode t)

;; Org mode
(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(defun my/set-line-spacing-org ()
  (setq line-spacing 7))

(defun my/set-org-download-directory ()
  (setq org-download-image-dir (concat org-directory "inserted-images")))

(defun my/set-auto-saving-all-org-buffers ()
  (add-hook 'after-save-hook 'org-save-all-org-buffers nil 'local ))

(defun my/set-org-customizations ()
  (my/set-line-spacing-org)
  (my/set-org-download-directory)
  (my/set-auto-saving-all-org-buffers)
  )

(add-hook 'org-mode-hook 'my/set-org-customizations)

(after! org
  (setq org-directory "~/Notes/Org-base/"
        org-agenda-files '("~/Notes/Org-base/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        ;; org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-html-with-toc nil
        org-hide-emphasis-markers t
        line-spacing 8
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "PROJ(p)"           ; A project that contains other tasks
             "ADV(a)"            ; A daily adventure
             "SIDE(s)"           ; A daily adventure
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" ))   ; Task has been cancelled
        org-todo-keyword-faces
          '(
            ("PROJ" . "#F1C40F")
            ("ADV" . "#C0392B")
            ("SIDE" . "#2980B9")
          )))



;; zzamboni org download config
(defun zz/org-download-paste-clipboard (&optional use-default-filename)
  (interactive "P")
  (require 'org-download)
  (let ((file
         (if (not use-default-filename)
             (read-string (format "Filename [%s]: "
                                  org-download-screenshot-basename)
                          nil nil org-download-screenshot-basename)
           nil)))
    (org-download-clipboard file)))

(use-package! org-download
  :config
  (setq org-download-method 'directory)
  (setq org-download-image-dir "images")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_")
  (setq org-image-actual-width nil)
  ;; (setq org-download-screenshot-method "scrot -s %s"))
  (setq org-download-screenshot-method "flameshot gui --raw > %s"))

(use-package! org-roam
  :custom
  (org-roam-directory "~/Notes/RoamNotes/")
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-enable))


(defun start-process-and-handle-exit (process-name buffer-name program &rest program-args)
  "Start a process and do something when this process is disabled."
  (let ((process (apply 'start-process process-name buffer-name program program-args)))
    (set-process-sentinel
     process
     (lambda (proc event)
       (when (string-match-p "finished" event)
         ;; Perform an action when the process is finished
         (org-roam-ui-mode 0)
         (message "%s has been finished" process-name)
         ;; Example action: Display a message
         (message "Process %s has exited. Performing some action..." (process-name proc)))))
    process))

;; Example call: Start a new process that lists the current directory.
(start-process-and-handle-exit "my-ls-process" "*my-ls-output*" "ls" "-l")

(defun org-roam-ui-run-in-webapp  ()
  (interactive)
  (unless (bound-and-true-p org-roam-ui-mode)
    (org-roam-ui-mode))
  (let ((process (start-process "Org Roam Ui" nil "~/.local/bin/org-roam-ui")))
    (set-process-sentinel
     process
     (lambda (proc event)
       (when (string-match-p "finished" event)
         (org-roam-ui-mode 0))))
    process))

(defun org-get-link ()
    ;; Get org-roam-canvas link to org-roam node containing point.
    ;; After invoking this, Ctrl-V on the Obsidian Canvas."
  (interactive)
  (let ((node (org-roam-node-at-point)))
    (if node
        (progn
          (message "Placed org-roam-canvas link on clipboard for node: %s" (org-roam-node-title node))
          (kill-new (url-encode-url (format "http://localhost:3813/node/?id=%s" (org-roam-node-id node)))))
      (message "No org-roam node found."))))

(defun my/org-replace-excalidraw-links ()
  ;; Replace 'excalidraw:/' with 'file:/' in the current buffer."
  (goto-char (point-min))
  (while (re-search-forward "excalidraw:/" nil t)
    (replace-match "file:/")))

(defun my/org-export-before-processing-hook (backend)
  ;; Hook to replace 'excalidraw:/' with 'file:/' only for HTML export.
  (when (org-export-derived-backend-p backend 'html)
    (my/org-replace-excalidraw-links)))

(add-hook 'org-export-before-processing-functions #'my/org-export-before-processing-hook)

(map! :map :default-mode
        :leader
        (:prefix ("r" . "org roam")
        :desc "See backlinks" "l" #'org-roam-buffer-toggle
        :desc "finalize capture " "c" #'org-capture-finalize
        :desc "run org roam ui " "u" #'org-roam-ui-run-in-webapp
        :desc "find node " "f" #'org-roam-node-find
        :desc "node insert" "i" #'org-roam-node-insert))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil
        org-roam-dailies-directory "journals/"
        org-roam-capture-templates '(
                                     ("r" "Note with resources" plain
                                      (file "~/Notes/RoamNotes/templates/resource.org")
                                      :if-new (file+head "%<%Y%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t)
                                     )
        )
  )

(use-package! org-excalidraw
  :config
  (setq org-excalidraw-directory "drawings"
        org-excalidraw-base "{\n    \"type\": \"excalidraw\",\n    \"version\": 2,\n    \"source\": \"https://excalidraw.com\",\n    \"elements\": [],\n    \"appState\": {\n      \"gridSize\": null,\n      \"viewBackgroundColor\": \"#cfd4de\"\n    },\n    \"files\": {}\n  }\n"
        )
)

(after! org
  (setq org-download-method 'directory)
  (setq org-download-image-dir "images")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_")
  (map! :map org-mode-map
        :leader
        (:prefix ("v" . "paste image")
        :desc "paste image from clipboard" "c" #'org-download-clipboard
        :desc "paste screenshot" "s" #'org-download-screenshot)
        :desc "toggle inline images" "i t" #'org-toggle-inline-images
        :desc "open at point" "i o" #'org-open-at-point))


;; Org auto-tangle
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

;; Rainbow mode
;; Displays the actual color for any hex value color.
;; Unfortunately, it destroys all highlihting in org-agenda
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode 'read-only-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )


;; (setq lsp-kotlin-language-server-path /usr/bin/kotlin-language-server)

;; (add-to-list 'execpath "<path to kotlin-language-server>")

;; (find-file "~/Notes/Org-base/Todo/0Today.org")

;; Todo lists maps
;; (map! :leader
;;       (:prefix ("o")
;;        :desc "Daily todo list" "t"
;;          #'(lambda () (interactive)
;;              (find-file (concat org-directory "Todo/0Today.org")))
;;         :desc "Weekly todo list" "w"
;;          #'(lambda () (interactive)
;;              (find-file (concat org-directory "Todo/1 Week.org"))
;;         )))
