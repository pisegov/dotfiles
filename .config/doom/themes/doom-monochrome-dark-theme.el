;;; doom-monochrome-dark-theme.el --- IlyasYOY Monochrome Dark -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Mikhail Pisegov
;; Source: https://github.com/IlyasYOY/dotfiles/blob/master/config/nvim/colors/ilyasyoy-monochrome.lua
;;
;;; Commentary:
;; Monochrome dark theme ported from IlyasYOY's Neovim dotfiles.
;; Emphasizes structure over color using bold, italic, and underline.
;;
;;; Code:

(require 'doom-themes)

(defgroup doom-monochrome-dark-theme nil
  "Options for the `doom-monochrome-dark' theme."
  :group 'doom-themes)

(def-doom-theme doom-monochrome-dark
  "A monochrome dark theme."

  ;; name        default   256       16
  ((bg         '("#222222" "#222222" "black"))
   (bg-alt     '("#2c2c2c" "#2c2c2c" "black"))
   (fg         '("#dadada" "#dadada" "white"))
   (fg-alt     '("#909090" "#909090" "brightblack"))

   (base0      '("#222222" "#222222" "black"))
   (base1      '("#2a2a2a" "#2a2a2a" "black"))
   (base2      '("#2c2c2c" "#2c2c2c" "black"))
   (base3      '("#303030" "#303030" "brightblack"))
   (base4      '("#3a3a3a" "#3a3a3a" "brightblack"))
   (base5      '("#909090" "#909090" "brightblack"))
   (base6      '("#b0b0b0" "#b0b0b0" "white"))
   (base7      '("#dadada" "#dadada" "white"))
   (base8      '("#eeeeee" "#eeeeee" "brightwhite"))

   (grey       base5)
   (red        '("#ff005f" "#ff005f" "red"))
   (orange     '("#cc8c00" "#cc8c00" "brightred"))
   (yellow     '("#ffaf00" "#ffaf00" "yellow"))
   (green      '("#6ab06a" "#6ab06a" "green"))
   (teal       '("#6ab06a" "#6ab06a" "brightgreen"))
   (blue       '("#0077aa" "#0077aa" "brightblue"))
   (dark-blue  '("#2d4560" "#2d4560" "blue"))
   (magenta    '("#8787af" "#8787af" "brightmagenta"))
   (violet     '("#8787af" "#8787af" "magenta"))
   (cyan       '("#909090" "#909090" "brightcyan"))
   (dark-cyan  '("#707070" "#707070" "cyan"))

   ;; face categories
   (highlight      orange)
   (vertical-bar   base3)
   (selection       base4)
   (builtin        fg)
   (comments       base5)
   (doc-comments   base5)
   (constants      fg)
   (functions      fg)
   (keywords       base5)
   (methods        fg)
   (operators      fg)
   (type           fg)
   (strings        fg)
   (variables      fg)
   (numbers        fg)
   (region         base4)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    blue)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom
   (modeline-fg    fg)
   (modeline-fg-alt base5)
   (modeline-bg    base2)
   (modeline-bg-alt base3))

  ;;;; Base theme face overrides
  (
   ;; --- base faces ---
   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg :weight 'bold)
   (hl-line :background base3)
   (cursor :background magenta)

   ;; --- font-lock ---
   (font-lock-comment-face :foreground comments)
   (font-lock-doc-face :foreground doc-comments :slant 'italic)
   (font-lock-keyword-face :foreground keywords)
   (font-lock-function-name-face :foreground functions :weight 'bold)
   (font-lock-variable-name-face :foreground variables)
   (font-lock-type-face :foreground type :underline t)
   (font-lock-string-face :foreground strings :slant 'italic)
   (font-lock-constant-face :foreground constants :slant 'italic)
   (font-lock-number-face :foreground numbers :slant 'italic)
   (font-lock-builtin-face :foreground builtin)
   (font-lock-warning-face :foreground (doom-blend red fg 0.5) :weight 'bold)

   ;; --- selection / search ---
   (region :background base4 :foreground yellow)
   (isearch :background blue :foreground bg)
   (lazy-highlight :background dark-blue :foreground fg)
   (match :foreground yellow :weight 'bold :underline t)

   ;; --- mode-line ---
   (mode-line :background modeline-bg :foreground modeline-fg :weight 'bold)
   (mode-line-inactive :background modeline-bg-alt :foreground modeline-fg-alt)
   (mode-line-emphasis :foreground highlight)
   (doom-modeline-bar :background modeline-bg)

   ;; --- paren match ---
   (show-paren-match :foreground yellow :weight 'bold)
   (show-paren-mismatch :foreground red :weight 'bold)

   ;; --- diffs ---
   (diff-added :background green :foreground fg)
   (diff-removed :background red :foreground fg)
   (diff-changed :background dark-blue :foreground fg)
   ((magit-diff-added-highlight &override) :foreground fg :background (doom-blend green bg 0.3))
   ((magit-diff-removed-highlight &override) :foreground fg :background (doom-blend red bg 0.3))

   ;; --- org-mode ---
   ((org-block &override) :background base1)
   ((org-code &override) :foreground fg :background base1)
   (org-document-title :foreground fg :weight 'bold)
   ((org-level-1 &override) :foreground fg :weight 'bold)
   ((org-level-2 &override) :foreground fg :weight 'bold)
   ((org-level-3 &override) :foreground fg :weight 'bold)

   ;; --- markdown ---
   (markdown-header-face :foreground fg :weight 'bold)
   ((markdown-code-face &override) :background base1)
   (markdown-bold-face :foreground fg :weight 'bold)
   (markdown-italic-face :foreground fg :slant 'italic)
   (markdown-link-face :foreground blue :underline t)

   ;; --- UI ---
   (fringe :background bg :foreground base5)
   (vertical-border :foreground base3)
   (minibuffer-prompt :foreground fg :weight 'bold)

   ;; --- company / corfu ---
   (company-tooltip :background base2 :foreground fg)
   (company-tooltip-selection :background orange :foreground bg)
   (company-tooltip-common :foreground blue :weight 'bold)

   ;; --- vertico / ivy ---
   ((ivy-current-match &override) :background orange :foreground bg :weight 'bold)
   (vertico-current :background orange :foreground bg :weight 'bold)

   ;; --- treemacs ---
   (treemacs-root-face :foreground fg :weight 'bold)

   ;; --- solaire ---
   (solaire-default-face :background bg-alt :foreground fg)
   (solaire-mode-line-face :inherit 'mode-line :background modeline-bg-alt)
   (solaire-mode-line-inactive-face :inherit 'mode-line-inactive :background (doom-darken modeline-bg-alt 0.05)))

  ;;;; Base theme variable overrides
  ())

;;; doom-monochrome-dark-theme.el ends here
