;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq which-key-idle-delay 0.0)

;; Emacs doesnt work very well with fish
(setq shell-file-name "/bin/zsh")

(setq fancy-splash-image "~/.doom.d/banners/doom.svg")


;; auto-save-visited only in org
(defun my/org-auto-save ()
  (setq-local auto-save-visited-interval 2)
  (auto-save-visited-mode 1))

(add-hook 'org-mode-hook #'my/org-auto-save)


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq doom-font (font-spec :family "Maple Mono NF" :size 22 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "Maple Mono NF" :weight 'semi-bold)
      doom-serif-font (font-spec :family "Maple Mono NF" :weight 'semi-bold)
      doom-big-font (font-spec :family "Maple Mono NF" :size 26 :weight 'semi-bold)
      doom-symbol-font (font-spec :family "Noto Color Emoji" ))

(setq doom-theme 'doom-palenight)
;; (setq doom-theme 'doom-moonlight)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

(after! org
  (custom-set-faces
   '(org-level-1 ((t (:height 1.5  :inherit outline-1 ))))
   '(org-level-2 ((t (:height 1.3  :inherit outline-2 ))))
   '(org-level-3 ((t (:height 1.25  :inherit outline-3 ))))
   '(org-level-4 ((t (:height 1.15  :inherit outline-4 ))))
   '(org-level-5 ((t (:height 1.1  :inherit outline-5 ))))
   '(org-level-6 ((t (:height 1.08  :inherit outline-6 ))))
   '(org-level-7 ((t (:height 1.05  :inherit outline-7 ))))
   '(org-level-8 ((t (:height 1.05  :inherit outline-8 )))))

  (setq org-agenda-files (list "~/org/refile.org"
                               "~/org/personal.org"
                               "~/org/uni.org"
                               "~/org/journal.org"
                               "~/org/projects.org"
                               "~/org/notes.org"
                               "~/org/todo.org"
                               "~/org/snippets.org"
                               "~/org/pocket.org"))
  (setq org-log-done 'time)
  (add-to-list 'org-capture-templates
               '("r" "Refile" entry
                 (file+headline "~/org/refile.org" "Inbox")
                 "* %?\n%U"))
  (add-to-list 'org-capture-templates
               '("T" "TODO" entry
                 (file+headline "~/org/todo.org" "Inbox")
                 "* TODO %?\n  %i\n  %a"))
  (defun my/org-capture-snippet-by-language ()
    "Find or create a language headline for the snippet."
    (let ((language (read-string "Language: ")))
      (setq my/capture-language language)  ; Store for template use
      (goto-char (point-min))
      ;; Look for existing language heading under "Snippets"
      (if (re-search-forward "^\\* Snippets$" nil t)
          (progn
            ;; Found "Snippets", now look for the language under it
            (if (re-search-forward (concat "^\\*\\* " (regexp-quote language) "$")
                                   (save-excursion
                                     (or (re-search-forward "^\\* " nil t)
                                         (point-max))) t)
                ;; Found existing language heading
                (end-of-line)
              ;; Language heading doesn't exist, create it
              (goto-char (match-end 0))
              (insert "\n** " language)
              (end-of-line)))
        ;; "Snippets" heading not found, something's wrong
        (error "Snippets heading not found"))))
  (add-to-list 'org-capture-templates
               '("s" "Code Snippet" entry
                 (file+function "~/org/snippets.org" my/org-capture-snippet-by-language)
                 "*** %^{Title}\nCaptured: %U\nSource: [[file://%F][%f]]\n\n#+BEGIN_SRC %(downcase my/capture-language)\n%i%?\n#+END_SRC\n\n"))
  (add-to-list 'org-capture-templates
               '("m" "Meeting" entry
                 (file "~/org/refile.org")
                 "* Meeting [%<%Y-%m-%d %a>]\n** Hiwi\n** Masterarbeit\n")))

;; Set org-capture to create missing outline levels
(setq org-capture-templates-contexts nil)


(after! org-modern
  (setq org-modern-star 'replace
        org-modern-replace-stars "◉○✸✿◉○✸✿◉○✸✿◉○✸✿"

        org-modern-keyword nil                    ; Disable #+TITLE, #+AUTHOR etc. styling
        ;; org-modern-block nil                      ; Disable source block styling
        ;; org-modern-block-fringe nil               ; Disable block fringe styling
        ;; org-modern-block-name nil                 ; Disable block name styling
        org-modern-drawer nil                     ; Disable drawer styling
        org-modern-tag nil                        ; Disable tag styling
        org-modern-priority nil                   ; Disable priority styling
        org-modern-todo nil                       ; Disable TODO keyword styling
        org-modern-timestamp nil                  ; Disable timestamp styling
        org-modern-statistics nil                 ; Disable statistics styling
        org-modern-progress nil                   ; Disable progress bar styling
        ;; org-modern-horizontal-rule nil            ; Disable horizontal rule styling
        org-modern-footnote nil                   ; Disable footnote styling
        org-modern-internal-target nil            ; Disable internal target styling
        org-modern-radio-target nil               ; Disable radio target styling
        ;; org-modern-code nil                       ; Disable inline code styling
        org-modern-verbatim nil                   ; Disable verbatim styling
        org-modern-table nil                      ; Disable table styling
        org-modern-list nil                       ; Disable list styling
        org-modern-checkbox nil                   ; Disable checkbox styling
        ;; org-modern-fold-stars nil                 ; Disable star folding indicators
        ;; org-modern-hide-stars nil                ; Disable leading stars
        ))

;; (after! consult
;;   (setq consult-imenu-config
;;         '((lua-mode :types ((?f "Functions" font-lock-function-name-face))))))
(after! consult
  (setq consult-imenu-config
        '((lua-mode :types ((?f "Function" font-lock-function-name-face))))))


(after! corfu
  (setq corfu-auto-delay 0.1))


(after! flyspell
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary-alist
        '(("de_DE,en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "de_DE,en_US") nil utf-8)))
  (setq ispell-dictionary "de_DE,en_US"))

(after! langtool
  (setq langtool-default-language "de-DE")

  (defun my/quick-grammar-check ()
    (interactive)
    (let ((lang (completing-read "Language: " '("de-DE" "en-US"))))
      (setq langtool-default-language lang)
      (langtool-check)))

  (map! :leader "cg" #'my/quick-grammar-check))

;; Make Emacs transparent
;; ;; (set-frame-parameter nil 'alpha-background 90)
;; ;;(add-to-list 'default-frame-alist '(alpha-background . 90))
