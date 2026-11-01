;;; doom-monochrome-light-theme.el --- IlyasYOY Monochrome Light -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Mikhail Pisegov
;; Source: https://github.com/IlyasYOY/dotfiles/blob/master/config/nvim/colors/ilyasyoy-monochrome.lua
;;
;;; Commentary:
;; Monochrome light theme ported from IlyasYOY's Neovim dotfiles.
;; Emphasizes structure over color using bold, italic, and underline.
;;
;;; Code:

(require 'doom-themes)

(defgroup doom-monochrome-light-theme nil
  "Options for the `doom-monochrome-light' theme."
  :group 'doom-themes)

(def-doom-theme doom-monochrome-light
  "A monochrome light theme."

  ;; name        default   256       16
  ((bg         '("#eeeeee" "#eeeeee" "white"))
   (bg-alt     '("#d7d7d7" "#d7d7d7" "brightwhite"))
   (fg         '("#000000" "#000000" "black"))
   (fg-alt     '("#626262" "#626262" "brightblack"))

   (base0      '("#eeeeee" "#eeeeee" "white"))
   (base1      '("#e4e4e4" "#e4e4e4" "brightwhite"))
   (base2      '("#d7d7d7" "#d7d7d7" "brightwhite"))
   (base3      '("#cccccc" "#cccccc" "brightwhite"))
   (base4      '("#b0b0b0" "#b0b0b0" "brightblack"))
   (base5      '("#626262" "#626262" "brightblack"))
   (base6      '("#3a3a3a" "#3a3a3a" "black"))
   (base7      '("#222222" "#222222" "black"))
   (base8      '("#000000" "#000000" "black"))

   (grey       base5)
   (red        '("#ff005f" "#ff005f" "red"))
   (orange     '("#cc8c00" "#cc8c00" "brightred"))
   (yellow     '("#ffaf00" "#ffaf00" "yellow"))
   (green      '("#2d8a2d" "#2d8a2d" "green"))
   (teal       '("#2d8a2d" "#2d8a2d" "brightgreen"))
   (blue       '("#0077cc" "#0077cc" "brightblue"))
   (dark-blue  '("#7ab5e0" "#7ab5e0" "blue"))
   (magenta    '("#8787af" "#8787af" "brightmagenta"))
   (violet     '("#8787af" "#8787af" "magenta"))
   (cyan       '("#626262" "#626262" "brightcyan"))
   (dark-cyan  '("#626262" "#626262" "cyan"))

   ;; face categories
   (highlight      orange)
   (vertical-bar   base3)
   (selection       base1)
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
   (region         base1)
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
   (modeline-bg-alt base1))

  ;;;; Base theme face overrides
  (
   ;; --- base faces ---
   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg :weight 'bold)
   (hl-line :background base1)
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
   (region :background base1 :foreground orange)
   (isearch :background blue :foreground bg)
   (lazy-highlight :background dark-blue :foreground fg)
   (match :foreground orange :weight 'bold :underline t)

   ;; --- mode-line ---
   (mode-line :background modeline-bg :foreground modeline-fg :weight 'bold)
   (mode-line-inactive :background modeline-bg-alt :foreground modeline-fg-alt)
   (mode-line-emphasis :foreground highlight)
   (doom-modeline-bar :background modeline-bg)

   ;; --- paren match ---
   (show-paren-match :foreground orange :weight 'bold)
   (show-paren-mismatch :foreground red :weight 'bold)

   ;; --- diffs ---
   (diff-added :background green :foreground fg)
   (diff-removed :background red :foreground fg)
   (diff-changed :background dark-blue :foreground fg)
   ((magit-diff-added-highlight &override) :foreground fg :background (doom-blend green bg 0.2))
   ((magit-diff-removed-highlight &override) :foreground fg :background (doom-blend red bg 0.2))

   ;; --- org-mode ---
   ((org-block &override) :background base2)
   ((org-code &override) :foreground fg :background base2)
   (org-document-title :foreground fg :weight 'bold)
   ((org-level-1 &override) :foreground fg :weight 'bold)
   ((org-level-2 &override) :foreground fg :weight 'bold)
   ((org-level-3 &override) :foreground fg :weight 'bold)

   ;; --- markdown ---
   (markdown-header-face :foreground fg :weight 'bold)
   ((markdown-code-face &override) :background base2)
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

;;; doom-monochrome-light-theme.el ends here
