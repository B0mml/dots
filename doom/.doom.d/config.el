;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;
;;; UI & Core

(setq shell-file-name "/bin/zsh"
      which-key-idle-delay 0.0
      fancy-splash-image "~/.doom.d/banners/doom.svg"
      display-line-numbers-type 'relative
      ;; doom-theme 'doom-bluloco-dark)
      doom-theme 'doom-horizon)

(setq doom-font (font-spec :family "Maple Mono NF" :size 24 :weight 'semi-bold)
      doom-big-font (font-spec :family "Maple Mono NF" :size 26 :weight 'semi-bold)
      doom-symbol-font (font-spec :family "Noto Color Emoji"))


;;
;;; Completion (Corfu)

(setq +corfu-want-tab-prefer-expand-snippets t
      +corfu-want-tab-prefer-navigating-snippets t
      +corfu-want-ret-to-confirm t)

(after! corfu
  ;; Auto-completion popup triggers quickly as you type
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1
        corfu-preselect 'first)  ; Preselect 1st candidate so doc popup can trigger immediately

  ;; Enable documentation popup next to completion candidate
  (require 'corfu-popupinfo)
  (corfu-popupinfo-mode 1)
  (setq corfu-popupinfo-delay '(0.2 . 0.1))

  ;; Keybindings to toggle/view doc during completion
  (define-key corfu-map (kbd "C-h") #'corfu-popupinfo-toggle)
  (define-key corfu-map (kbd "M-h") #'corfu-popupinfo-documentation)
  (define-key corfu-map (kbd "M-d") #'corfu-popupinfo-documentation)
  (define-key corfu-map (kbd "M-g") #'corfu-popupinfo-location)

  ;; Fix Emacs 31 popup positioning nil-check
  (defadvice! +corfu--candidates-popup-safe-a (orig-fn pos &rest args)
    "Prevent wrong-type-argument crash when pos is nil."
    :around #'corfu--candidates-popup
    (when pos
      (apply orig-fn pos args))))

(after! lsp-completion
  (defadvice! +lsp-completion-fix-doc-fallback-a (orig-fn item)
    "Fix `lsp-completion--get-documentation' returning nil when detail is contained in doc."
    :around #'lsp-completion--get-documentation
    (let ((doc (funcall orig-fn item)))
      (if (and doc (not (string-blank-p doc)))
          doc
        (when-let* ((lsp-item (get-text-property 0 'lsp-completion-item (lsp-completion--resolve item)))
                    (raw-doc (or (lsp:completion-item-documentation? lsp-item)
                                 (lsp:completion-item-detail? lsp-item))))
          (let ((rendered (lsp--render-element raw-doc)))
            (unless (string-blank-p rendered)
              (put-text-property 0 (length item) 'lsp-completion-item-doc rendered item)
              rendered)))))))




;;
;;; Consult & Navigation

(after! consult
  (setq consult-imenu-config
        '((lua-mode :types ((?f "Function" font-lock-function-name-face))))))


;;
;;; Spell Checking (Hunspell DE/EN)

(after! flyspell
  (setq ispell-program-name "hunspell"
        ispell-dictionary "de_DE,en_US"
        ispell-local-dictionary-alist
        '(("de_DE,en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "de_DE,en_US") nil utf-8))))


;;
;;; Org-Mode

(setq org-directory "~/org/")

(after! org
  (setq org-log-done 'time
        org-agenda-files '("~/org/"))

  (custom-set-faces!
    '(org-level-1 :height 1.4)
    '(org-level-2 :height 1.25)
    '(org-level-3 :height 1.15)
    '(org-level-4 :height 1.1))

  ;; Auto-save visited org files
  (defun my/org-auto-save ()
    (setq-local auto-save-visited-interval 2)
    (auto-save-visited-mode 1))
  (add-hook 'org-mode-hook #'my/org-auto-save)

  ;; Capture Templates
  (setq org-capture-templates
        '(("r" "Refile" entry
           (file+headline "~/org/refile.org" "Inbox")
           "* %?\n%U")
          ("T" "TODO" entry
           (file+headline "~/org/todo.org" "Inbox")
           "* TODO %?\n  %i\n  %a")
          ("m" "Meeting" entry
           (file "~/org/refile.org")
           "* Meeting [%<%Y-%m-%d %a>]\n** Work\n** Notes\n")
          ("s" "Code Snippet" entry
           (file+headline "~/org/snippets.org" "Snippets")
           "** %^{Language}\n*** %^{Title}\nCaptured: %U\nSource: [[file://%F][%f]]\n\n#+BEGIN_SRC %\\1\n%i%?\n#+END_SRC\n\n"))))

;; Only use org-modern for heading stars
(after! org-modern
  (setq org-modern-star 'replace
        org-modern-replace-stars "◉○✸✿"
        org-modern-table nil
        org-modern-tag nil
        org-modern-timestamp nil
        org-modern-todo nil
        org-modern-priority nil
        org-modern-checkbox nil
        org-modern-progress nil
        org-modern-statistics nil
        org-modern-keyword nil
        org-modern-drawer nil
        org-modern-block nil
        org-modern-horizontal-rule nil))


;;
;;; Module Documentation Helper (Fix 'K' and 'gd' in init.el)

(defadvice! +fix-doom-docs-module-args-a (fn key &optional visit-dir? &rest rest)
  "Allow `doom/docs-module` to accept legacy (GROUP MODULE &optional VISIT-DIR?) calls."
  :around #'doom/docs-module
  (if (keywordp key)
      (let* ((group key)
             (module (or (car-safe visit-dir?) visit-dir?))
             (visit? (car rest)))
        (funcall fn (list t group module) visit?))
    (funcall fn key visit-dir?)))
