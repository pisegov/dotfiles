;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; DO NOT EDIT THIS CONFIG. IT'S AUTO TANGLED FROM README.ORG
;; EDIT README.ORG INSTEAD

(setq user-full-name "Mikhail Pisegov"
      user-mail-address "pisegov.mikhail@gmail.com")

(setq doom-font (font-spec :size 17))

(setq doom-theme 'doom-xcode)

(setq display-line-numbers-type t)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(add-to-list 'default-frame-alist '(alpha . 95))

(map! :nv "j" #'evil-next-visual-line)
(map! :nv "k" #'evil-previous-visual-line)

(map! :nv "K" #'evil-backward-paragraph)
(map! :nv "J" #'evil-forward-paragraph)
(map! :nv "H" #'evil-first-non-blank)
(map! :nv "L" #'evil-end-of-line)

(map! :i "C-k" #'evil-previous-visual-line)
(map! :i "C-j" #'evil-next-visual-line)
(map! :i "C-h" #'evil-backward-char)
(map! :i "C-l" #'evil-forward-char)

(map! :n "C-k" #'evil-window-up)
(map! :n "C-j" #'evil-window-down)
(map! :n "C-h" #'evil-window-left)
(map! :n "C-l" #'evil-window-right)

(map! :n "C-S-k" #'evil-window-increase-height)
(map! :n "C-S-j" #'evil-window-decrease-height)
(map! :n "C-S-h" #'evil-window-decrease-width)
(map! :n "C-S-l" #'evil-window-increase-width)

(map! :nvi "C-/" #'evilnc-comment-or-uncomment-lines)

(map! :vi "C-v" #'evil-paste-after)

(setq evil-kill-on-visual-paste nil)

(after! evil
  (use-package! evil-xkbswitch
    :config
    (setq evil-xkbswitch-set-layout (getenv "XKBSWITCH_SET_LAYOUT")
          evil-xkbswitch-get-layout (getenv "XKBSWITCH_GET_LAYOUT")
          evil-xkbswitch--us-method (getenv "XKBSWITCH_US_METHOD"))
    (evil-xkbswitch-mode t)))

(use-package! char-fold
  :config
  (setq char-fold-symmetric t
        search-default-mode #'char-fold-to-regexp))

(use-package! reverse-im
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :config
  (setq reverse-im-char-fold t ; use lax matching
        reverse-im-read-char-advice-function #'reverse-im-read-char-include
        reverse-im-input-methods '("russian-computer")) ; translate these methods
  (reverse-im-mode t)) ; turn the mode on

(add-hook! 'text-mode-hook  'writeroom-mode)
(add-hook! 'prog-mode-hook  'writeroom-mode)
(add-hook! 'conf-mode-hook 'writeroom-mode)

(setq org-directory "~/Notes/Org-base")

(add-hook! 'org-mode-hook 'org-auto-tangle-mode)

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

(after! org (setq line-spacing 0.25))

(after! org
  (add-hook 'after-save-hook 'org-save-all-org-buffers nil 'local))

(after! org
  (custom-set-faces!
    '(org-block :height 0.85)
    '(org-code :height 0.85)))

(after! org
  (setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "PROJ(p)"           ; A project that contains other tasks
           "ADV(a)"            ; A daily adventure
           "SIDE(s)"           ; A daily side quest
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "HOLD(h)"           ; Task has been postponed
           "CANCELLED(c)" ))   ; Task has been cancelled
        ))

(use-package! org-modern
  :after org
  :config
  ;; Enable org-modern globally for all org buffers
  (global-org-modern-mode)

  ;; Customization options (optional)
  (setq org-modern-keyword nil             ; Don't style #+KEYWORD
        org-modern-checkbox nil            ; Don't style checkboxes
        org-modern-todo nil                ; Don't style checkboxes
        org-modern-table-vertical 1        ; Table styling
        org-modern-table-horizontal 0.2    ; Table styling
        org-modern-block-fringe nil        ; Disable code block borders
        org-auto-align-tags nil
        org-tags-column 0
        org-catch-invisible-edits 'show-and-error
        org-special-ctrl-a/e t
        org-insert-heading-respect-content t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-agenda-tags-column 0
        org-ellipsis "…"
        org-modern-list '((43 . "➤")       ; Custom list bullets
                          (45 . "•"))
        org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")  ; Custom bullets
        org-modern-hide-stars nil                              ; Show/hide original stars
        org-modern-fold-stars       ; Folding indicators
        '(("▶" . "▼") ("▷" . "▽"))))

(use-package! org-modern-indent)
(add-hook! 'org-mode-hook 'org-modern-indent-mode)

(use-package! org-download
  :after org
  :config
  (setq org-download-method 'directory
        org-download-image-dir "images"
        org-download-heading-lvl nil
        org-download-timestamp "%Y%m%d-%H%M%S_"
        org-image-actual-width nil
        org-download-screenshot-method
        (cond ((eq system-type 'darwin) "screencapture -i %s")
              ((eq system-type 'gnu/linux) "flameshot gui --raw > %s")
              (t "scrot -s %s")))
  (map! :map org-mode-map
        :leader
        (:prefix ("v" . "paste image")
         :desc "paste image from clipboard" "c" #'org-download-clipboard
         :desc "paste screenshot" "s" #'org-download-screenshot
         :desc "toggle inline images" "t" #'org-toggle-inline-images
         :desc "open at point" "o" #'org-open-at-point))
  )

(use-package! org-roam
  :custom
  (org-roam-directory "~/Notes/RoamNotes/")
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-enable))

(map! :map :default-mode
      :leader
      (:prefix ("r" . "org roam")
       :desc "See backlinks" "l" #'org-roam-buffer-toggle
       :desc "finalize capture " "c" #'org-capture-finalize
       :desc "run org roam ui " "u" #'org-roam-ui-open
       :desc "find node " "f" #'org-roam-node-find
       :desc "node insert" "i" #'org-roam-node-insert))

(after! org-roam
  (setq org-roam-dailies-directory "journals/"
        org-roam-capture-templates '(
                                     ("r" "Note with resources" plain
                                      (file "~/Notes/RoamNotes/templates/resource.org")
                                      :if-new (file+head "%<%Y%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t)
                                     ("d" "Daily note" plain
                                      (file "~/Notes/RoamNotes/templates/daily.org")
                                      :if-new (file+head "%<%Y%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                      :unnarrowed t)
                                     )
        org-roam-dailies-capture-templates '(
                                             ("d" "default" entry "* %?"
                                              :target (file+head "%<%Y-%m-%d>.org"
                                                                 "#+title: %<%Y-%m-%d>\n\n[[roam:Daily note link]]\n")))
        ))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil
        org-roam-ui-browser-function #'my/safari-webapp-open
        ))

(defun my/safari-webapp-open (url &rest _)
  "Open org-roam-ui - Safari web app on macOS, local binary on Linux."
  (cond
   ;; macOS - open existing Safari web app
   ((eq system-type 'darwin)
    (start-process "safari-webapp" nil
                   "open" "-a" "ORUI"))  ; Replace with your web app name

   ;; Linux - run local org-roam-ui binary
   ((eq system-type 'gnu/linux)
    (let ((roam-ui-bin (expand-file-name "~/.local/bin/org-roam-ui")))
      (if (file-exists-p roam-ui-bin)
          (start-process "org-roam-ui" nil roam-ui-bin)
        (message "org-roam-ui binary not found at %s" roam-ui-bin))))

   ;; Fallback for other systems
   (t (browse-url url))))

(after! org-roam
  (defun my/org-roam-buffer-setup ()
    "Setup function for org-roam buffers."
    (when (and (derived-mode-p 'org-mode) (org-roam-file-p))
      (message "Setting up org-roam buffer")
      (org-excalidraw-initialize)
      ))

  (add-hook! 'org-mode-hook #'my/org-roam-buffer-setup))

(use-package! org-yt)
(use-package! org-excalidraw
  :after org-yt
  :config
  (setq org-excalidraw-directory (concat org-roam-directory "drawings")
        org-excalidraw-base "{\n    \"type\": \"excalidraw\",\n    \"version\": 2,\n    \"source\": \"https://excalidraw.com\",\n    \"elements\": [],\n    \"appState\": {\n      \"gridSize\": null,\n      \"viewBackgroundColor\": \"#cfd4de\"\n    },\n    \"files\": {}\n  }\n"
        )
  )
(add-hook 'org-roam-mode-hook 'org-excalidraw-initialize)

(setq visual-fill-column-width 80
      visual-fill-column-center-text t)
(defun my/org-present-start ()
  ;; Center the presentation and wrap lines
  (visual-fill-column-mode 1)
  (visual-line-mode 1)
;; Tweak font sizes

    ;; (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
    ;;                                 (header-line (:height 4.0) variable-pitch)
    ;;                                 (org-document-title (:height 1.75) org-document-title)
    ;;                                 ;; (org-code (:height 1.55) org-code)
    ;;                                 ;; (org-verbatim (:height 1.55) org-verbatim)
    ;;                                 (org-block (:height 1.25) org-block)
    ;;                                 ;; (org-block-begin-line (:height 0.7) org-block)))
    (setq-local face-remapping-alist '((default (:height 1.75) variable-pitch)
                                    (header-line (:height 4.0) variable-pitch)
                                    (org-link (:underline nil) org-link)
                                    (org-document-title (:height 1.75) org-document-title)
                                    (org-code (:height 1.0) org-code)
                                    ;; (org-verbatim (:height 1.55) org-verbatim)
                                    (org-block (:height 1.05) org-block)
                                    (org-block-begin-line (:height 0.7) org-block)))
(setq header-line-format " ")
(menu-bar--display-line-numbers-mode-none)
(org-modern-indent-mode 0)

;; (dolist (face '((org-level-1 . 1.2)
;;                 (org-level-2 . 1.1)
;;                 (org-level-3 . 1.05)
;;                 (org-level-4 . 1.0)
;;                 (org-level-5 . 1.1)
;;                 (org-level-6 . 1.1)
;;                 (org-level-7 . 1.1)
;;                 (org-level-8 . 1.1)))
;;   (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'medium :height (cdr face)))

  )

(defun my/org-present-end ()
  ;; Stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
;; Reset font customizations
(setq-local face-remapping-alist '((default variable-pitch default)))
(setq header-line-format nil)
(menu-bar--display-line-numbers-mode-visual)
(org-modern-indent-mode 1)
  )

;; Register hooks with org-present
(add-hook 'org-present-mode-hook 'my/org-present-start)
(add-hook 'org-present-mode-quit-hook 'my/org-present-end)

(defun my/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))

(add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)

(after! projectile
  (map! :leader
        :desc "Find project file"
        "f f" #'projectile-find-file))

(map! :leader "f F" #'find-file)

(map! :leader
      :desc "Search with rg for files in current project"
      "f g" #'consult-ripgrep)

(map! :leader
      "/" #'consult-ripgrep)

(after! consult
  (consult-customize consult-ripgrep
                     :preview-key '(:debounce 0.2 any)))

(defun my/search-project-at-point ()
  (interactive)
  (consult-ripgrep (projectile-project-root) (thing-at-point 'symbol t)))

(map! :leader
      :desc "Grep project for symbol at point"
      "*" #'my/search-project-at-point)

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

(setq TeX-engine 'xetex)
(setq TeX-PDF-mode t)
(setq pdf-latex-command "xelatex")

(setq dired-listing-switches
      "-ahl -v --group-directories-first")

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

(setq dired-preview-delay 0)
(setq dired-preview-max-size (expt 2 20))
(setq dired-preview-ignored-extensions-regexp
      (concat "\\."
              ;; "\\(mkv\\|webm\\|mp4\\|mp3\\|ogg\\|m4a"
              "\\(mkv\\|webm\\|mp4\\|mp3\\|ogg\\|m4a"
              "\\|gz\\|zst\\|tar\\|xz\\|rar\\|zip"
              "\\|iso\\|epub\\|pdf\\)"))

(add-hook 'dired-mode-hook 'dired-preview-mode)

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
  ;; (kbd "M") 'dired-do-chmod
  ;; (kbd "O") 'dired-do-chown
  ;; (kbd "R") 'dired-do-rename
  ;; (kbd "T") 'dired-do-touch
  ;; (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  ;; (kbd "Z") 'dired-do-compress
  ;; (kbd "+") 'dired-create-directory
  ;; (kbd "-") 'dired-do-kill-lines
  ;; (kbd "% l") 'dired-downcase
  ;; (kbd "% m") 'dired-mark-files-regexp
  ;; (kbd "% u") 'dired-upcase
  ;; (kbd "* %") 'dired-mark-files-regexp
  ;; (kbd "* .") 'dired-mark-extension
  ;; (kbd "* /") 'dired-mark-directories
  ;; (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(setq dired-open-extensions
      (let ((image-viewer (cond ((eq system-type 'darwin) "open")
                                ((eq system-type 'gnu/linux) "imv")
                                (t "xdg-open")))
            (video-player (cond ((eq system-type 'darwin) "open")
                                (t "mpv")))
            (audio-player (cond ((eq system-type 'darwin) "open")
                                (t "mpv"))))
        `(("gif" . ,image-viewer)
          ("jpg" . ,image-viewer)
          ("jpeg" . ,image-viewer)
          ("png" . ,image-viewer)
          ("webp" . ,image-viewer)
          ("mkv" . ,video-player)
          ("mp4" . ,video-player)
          ("avi" . ,video-player)
          ("mov" . ,video-player)
          ("mp3" . ,audio-player)
          ("flac" . ,audio-player)
          ("m4a" . ,audio-player))))
