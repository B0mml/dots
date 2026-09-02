;;; doom-base46-custom-theme.el --- Port of Base46 custom palette (Muted OLED) -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Ported to Doom Emacs
;;
;;; Commentary:
;; A deeply dark theme ported from an NvChad/base46 custom palette,
;; using an asphalt (#121212) canvas paired with lowered luminance/saturation
;; across syntax accents to reduce eye strain and eliminate neon glare.
;;
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup doom-base46-custom-theme nil
  "Options for the `doom-base46-custom' theme."
  :group 'doom-themes)

(defcustom doom-base46-custom-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-base46-custom-theme
  :type 'boolean)

(defcustom doom-base46-custom-brighter-comments nil
  "If non-nil, comments will use a softer pastel green instead of muted grey."
  :group 'doom-base46-custom-theme
  :type 'boolean)

(defcustom doom-base46-custom-comment-bg nil
  "If non-nil, comments will have a subtle, darker background."
  :group 'doom-base46-custom-theme
  :type 'boolean)

(defcustom doom-base46-custom-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds padding to the mode-line."
  :group 'doom-base46-custom-theme
  :type '(choice integer boolean))

;;
;;; Theme definition

(def-doom-theme doom-base46-custom
    "A soft, low-glare deep dark theme ported from an NvChad/base46 palette."

  ;; name          default     256         16
  ((bg           '("#121212" "#121212" nil))
   (bg-alt       '("#0d0d0d" "#0d0d0d" nil))
   (base0        '("#080808" "#080808" "black"))
   (base1        '("#121212" "#121212" "black"))
   (base2        '("#171717" "#171717" "brightblack"))
   (base3        '("#1f1f1f" "#1f1f1f" "brightblack"))
   (base4        '("#282828" "#282828" "brightblack"))
   (base5        '("#3d3d3d" "#3d3d3d" "brightblack"))
   (base6        '("#555555" "#555555" "brightblack"))
   (base7        '("#707070" "#707070" "brightblack"))
   (base8        '("#d8d8d8" "#d8d8d8" "white"))
   ;; Slightly softened plain foreground & UI text
   (fg           '("#a8a8a8" "#a8a8a8" "white"))
   (fg-alt       '("#b8b8b8" "#b8b8b8" "white"))

   ;; Syntax Accents (calibrated for lower luminance/glare)
   (grey         '("#606060" "#606060" "brightblack"))
   (red          '("#d64a3d" "#d64a3d" "red"))          ; was #ff5647
   (orange       '("#ad8857" "#ad8857" "brightred"))    ; was #c9a26d
   (green        '("#2ea87f" "#2ea87f" "green"))        ; was #39cc9b
   (teal         '("#529fa6" "#529fa6" "brightgreen"))    ; was #66c3cc
   (yellow       '("#cbb254" "#cbb254" "yellow"))       ; was #f5d86a
   (blue         '("#587ec9" "#587ec9" "brightblue"))     ; was #6c95eb
   (dark-blue    '("#3d66b2" "#3d66b2" "blue"))           ; was #4a7bd4
   (magenta      '("#9f74d4" "#9f74d4" "magenta"))        ; was #c191ff
   (violet       '("#b26eb0" "#b26eb0" "brightmagenta"))  ; was #d688d4
   (cyan         '("#3e8fbe" "#3e8fbe" "brightcyan"))     ; was #4dabe4
   (dark-cyan    '("#6b6fa8" "#6b6fa8" "cyan"))

   ;; Palette additions
   (accent       '("#587ec9" "#587ec9" "brightblue"))
   (comment-col  '("#686868" "#686868" "brightblack"))
   (doc-col      '("#3e6a2c" "#3e6a2c" "green"))
   (soft-green   '("#6ea658" "#6ea658" "green"))        ; was #85c46c
   (str-light    '("#b59368" "#b59368" "yellow"))
   (amber-warn   '("#aa8200" "#aa8200" "yellow"))       ; was #cc9c00
   (pink-num     '("#c4779e" "#c4779e" "brightmagenta")) ; was #e791bc
   (border-col   '("#2e2e2e" "#2e2e2e" "brightblack"))
   (sep-line     '("#222222" "#222222" "brightblack"))

   ;; Face categories
   (highlight     accent)
   (vertical-bar  sep-line)
   (selection    '("#252525" "#252525" "brightblack"))
   (builtin       teal)
   (comments      (if doom-base46-custom-brighter-comments soft-green comment-col))
   (doc-comments  doc-col)
   (constants     teal)
   (functions     green)
   (keywords      blue)
   (methods       green)
   (operators    '("#a4a4a4" "#a4a4a4" "white"))
   (type          magenta)
   (strings       orange)
   (variables     fg)
   (numbers       pink-num)
   (region        selection)
   (error         red)
   (warning       amber-warn)
   (success       green)
   (vc-modified   yellow)
   (vc-added      green)
   (vc-deleted    red)

   ;; Modeline & custom elements
   (hidden        `(,(car bg) "black" "black"))
   (-modeline-pad
    (when doom-base46-custom-padded-modeline
      (if (integerp doom-base46-custom-padded-modeline)
          doom-base46-custom-padded-modeline 4)))

   (modeline-fg          fg-alt)
   (modeline-fg-alt      grey)
   (modeline-bg          (if doom-base46-custom-brighter-modeline base3 base2))
   (modeline-bg-alt      base0)
   (modeline-bg-inactive base0)
   (modeline-bg-inactive-alt base0))

  ;;;; Base theme face overrides
  (((font-lock-comment-face &override)
    :foreground comments
    :background (if doom-base46-custom-comment-bg (doom-lighten bg 0.04) 'unspecified)
    :slant 'italic)
   ((font-lock-doc-face &override) :foreground doc-comments :slant 'italic)
   ((font-lock-function-name-face &override) :foreground functions)
   ((font-lock-keyword-face &override) :foreground keywords)
   ((font-lock-type-face &override) :foreground type)
   ((font-lock-constant-face &override) :foreground constants)
   ((font-lock-variable-name-face &override) :foreground variables)
   ((font-lock-string-face &override) :foreground strings)
   ((font-lock-builtin-face &override) :foreground builtin)
   ((font-lock-escape-face &override) :foreground violet)

   ;; UI & Separators
   (vertical-border :foreground vertical-bar)
   (window-divider :foreground vertical-bar)

   ;; Rainbow delimiters
   (rainbow-delimiters-depth-1-face :foreground blue)
   (rainbow-delimiters-depth-2-face :foreground magenta)
   (rainbow-delimiters-depth-3-face :foreground green)
   (rainbow-delimiters-depth-4-face :foreground teal)

   ;; Line numbers
   ((line-number &override) :foreground base5 :background bg)
   ((line-number-current-line &override) :foreground base8 :background base3 :weight 'bold)

   ;; Modeline
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))

   ;; Popups / Company / Vertico
   ((tooltip &override) :background base2 :foreground fg-alt)
   ((company-tooltip &override) :background base2 :foreground fg-alt)
   ((company-tooltip-selection &override) :background base4 :foreground base8 :weight 'bold)
   ((vertico-current &override) :background base4 :foreground base8 :weight 'bold)

   ;; Indent guides
   ((highlight-indent-guides-odd-face &override) :background base2)
   ((highlight-indent-guides-even-face &override) :background base2)
   ((highlight-indent-guides-character-face &override) :foreground base3)

   ;; Highlight numbers
   (highlight-numbers-number :foreground numbers)

   ;; Magit / Diff
   (magit-diff-added :foreground green :background (doom-blend green bg 0.12))
   (magit-diff-added-highlight :foreground green :background (doom-blend green bg 0.22))
   (magit-diff-removed :foreground red :background (doom-blend red bg 0.12))
   (magit-diff-removed-highlight :foreground red :background (doom-blend red bg 0.22))

   ;; Org Mode
   (org-hide :foreground hidden)
   (org-block :background bg-alt)
   (org-block-begin-line :foreground comment-col :background bg-alt)
   (org-link :foreground dark-blue :underline t)))

(provide-theme 'doom-base46-custom)
