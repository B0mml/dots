;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;
;;; UI & Core Settings

(when-let (path (locate-library "ember-theme"))
  (add-to-list 'custom-theme-load-path (file-name-directory path)))

(setq shell-file-name "/bin/fish"
      which-key-idle-delay 0.1
      fancy-splash-image "~/.doom.d/banners/doom.svg"
      display-line-numbers-type 'relative
      doom-theme 'ember)

(setq doom-font (font-spec :family "Maple Mono NF" :size 22 :weight 'semi-bold)
      doom-big-font (font-spec :family "Maple Mono NF" :size 24 :weight 'semi-bold)
      doom-symbol-font (font-spec :family "Noto Color Emoji"))

(setq scroll-margin 5
      scroll-conservatively 100       ; Smooth 1-line scrolling without jump-recentering
      maximum-scroll-margin 0.5       ; Prevents scroll-margin from breaking small splits
      doom-modeline-modal nil)


;;
;;; Completion (Corfu)

(after! corfu
  (setq corfu-auto nil                ; Manual completion on demand
        corfu-preselect 'prompt)

  (corfu-popupinfo-mode 1)
  (setq corfu-popupinfo-delay '(0.2 . 0.1))

  ;; Close completion popup and stay in Insert mode
  (map! :map corfu-map
        :i "C-e" #'corfu-quit
        :i "C-g" #'corfu-quit)

  ;; Fix Emacs 31 popup positioning nil-check
  (defadvice! +corfu--candidates-popup-safe-a (orig-fn pos &rest args)
    "Prevent wrong-type-argument crash when pos is nil."
    :around #'corfu--candidates-popup
    (when pos
      (apply orig-fn pos args))))


;;
;;; Navigation, Search & Spell Checking

(after! consult
  (setq consult-imenu-config
        '((lua-mode :types ((?f "Function" font-lock-function-name-face))))))

(after! flyspell
  (setq ispell-program-name "hunspell"
        ispell-dictionary "de_DE,en_US"
        ispell-local-dictionary-alist
        '(("de_DE,en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "de_DE,en_US") nil utf-8))))


;;
;;; Diagnostics & Documentation

(after! eldoc
  (setq eldoc-documentation-strategy #'eldoc-documentation-default
        eldoc-echo-area-use-multiline-p nil))

(after! rustic
  (setq rustic-flycheck-setup-mode nil))

(after! flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-annotate-mode)
  (setq flycheck-annotate-current-line-style 'below
        flycheck-annotate-other-lines-style 'sideline)
  (remove-hook 'flycheck-mode-hook #'+syntax-init-popups-h)

  (custom-set-faces!
    '((flycheck-error flymake-error)
      :underline (:style line :color "#ff6b6b")
      :weight bold)
    '((flycheck-warning flymake-warning)
      :underline (:style line :color "#e5c07b")
      :weight bold)
    '((flycheck-info flymake-note)
      :underline (:style line :color "#98be65"))))


;;
;;; Org Mode & GTD Setup

(setq org-directory "~/org/")

(after! org
  (setq org-default-notes-file (expand-file-name "tasks.org" org-directory)
        org-agenda-files (list (expand-file-name "tasks.org" org-directory))
        org-log-done 'time)

  (custom-set-faces!
    '(org-level-1 :height 1.4)
    '(org-level-2 :height 1.25)
    '(org-level-3 :height 1.15)
    '(org-level-4 :height 1.1))

  ;; Capture templates: 'i' for agenda tasks, 'n' for atomic knowledge notes
  (setq org-capture-templates
        '(("i" "Inbox Task" entry
           (file+headline "~/org/tasks.org" "Inbox")
           "* TODO %?\n  Captured: %U\n  %i"
           :empty-lines 1)

          ("n" "New Denote Note (Knowledge / Snippet)" plain
           (file denote-last-path)
           #'denote-org-capture
           :no-save t
           :immediate-finish nil
           :kill-buffer t
           :jump-to-captured t))))

;; Minimal org-modern styling (heading stars only)
(after! org-modern
  (setq org-modern-star 'replace
        org-modern-replace-stars "◉○✸✿"))


;;
;;; Denote (Knowledge Management in ~/org/)

(use-package! denote
  :config
  (setq denote-directory (expand-file-name "~/org/")
        denote-file-type 'org
        denote-known-keywords '("emacs" "dev" "rust" "lua" "gamedev" "uni" "ideas" "golang" "learning" "website"))

  (add-hook 'dired-mode-hook #'denote-dired-mode)

  (map! :leader
        (:prefix-map ("n" . "notes")
                     (:prefix ("d" . "denote")
                      :desc "New note"              "n" #'denote
                      :desc "Open / Create note"    "d" #'denote-open-or-create
                      :desc "Find note"             "f" #'denote-open-or-create
                      :desc "Insert link"           "l" #'denote-link-or-create
                      :desc "Show backlinks"        "b" #'denote-backlinks
                      :desc "Rename file"           "r" #'denote-rename-file
                      :desc "Add keywords"          "k" #'denote-keywords-add
                      :desc "Remove keywords"       "K" #'denote-keywords-remove))))


;;
;;; LSP & Inlay Hints

(setq-default lsp-inlay-hint-enable nil)

(add-hook! '(rustic-mode-hook
             rust-mode-hook
             rust-ts-mode-hook
             go-mode-hook
             go-ts-mode-hook)
  (defun +lsp-enable-inlay-hints-locally-h ()
    (setq-local lsp-inlay-hint-enable t)))

(map! :leader
      :desc "Inlay hints" "t h" #'lsp-inlay-hints-mode)

(after! lsp-mode
  (setq lsp-idle-delay 0.1
        lsp-completion-enable-additional-text-edit t
        lsp-modeline-code-actions-enable t
        lsp-lens-enable nil
        lsp-warn-no-matched-clients nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-suggest-server-download nil))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil 
        lsp-ui-doc-enable nil))

(after! lsp-rust
  (setq lsp-rust-analyzer-cargo-all-targets nil
        lsp-rust-analyzer-diagnostics-enable nil
        lsp-rust-analyzer-hide-named-constructor t
        lsp-rust-analyzer-hide-closure-initialization t
        lsp-rust-analyzer-display-chaining-hints t
        lsp-rust-analyzer-display-parameter-hints nil
        lsp-rust-analyzer-display-reborrow-hints "never"
        lsp-rust-analyzer-closure-return-type-hints "never"
        lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial"
        lsp-rust-analyzer-max-inlay-hint-length 25))

(after! lsp-go
  (lsp-register-custom-settings
   '(("gopls.hints"
      ((assignVariableTypes . t)
       (compositeLiteralFields . t)
       (compositeLiteralTypes . t)
       (constantValues . t)
       (functionTypeParameters . t)
       (parameterNames . :json-false)
       (rangeVariableTypes . t))))))

(custom-set-faces!
  '(lsp-inlay-hint-face :inherit font-lock-comment-face :italic t))


;;
;;; Evil & Navigation Improvements

(setq evil-split-window-below t
      evil-vsplit-window-right t
      evil-ex-substitute-global t)

(map! :o "o" #'evil-inner-symbol)

(map! (:after evil-org
       :map evil-org-mode-map
       :n "gk" (cmds! (org-on-heading-p) #'org-backward-element #'evil-previous-visual-line)
       :n "gj" (cmds! (org-on-heading-p) #'org-forward-element #'evil-next-visual-line)))


;;
;;; Fixes & Hacks

(defadvice! +fix-doom-docs-module-args-a (fn key &optional visit-dir? &rest rest)
  "Allow `doom/docs-module` to accept legacy (GROUP MODULE &optional VISIT-DIR?) calls."
  :around #'doom/docs-module
  (if (keywordp key)
      (let* ((group key)
             (module (or (car-safe visit-dir?) visit-dir?))
             (visit? (car rest)))
        (funcall fn (list t group module) visit?))
    (funcall fn key visit-dir?)))

;;
;;; Indent Bars

(use-package! indent-bars
  :hook (prog-mode . indent-bars-mode)
  :config
  (setq indent-bars-treesit-support t
        indent-bars-no-descend-string t
        indent-bars-width-frac 0.15     ; Bar width as fraction of char width (thin)
        indent-bars-pad-frac 0.1        ; Offset within the column
        indent-bars-color '(font-lock-comment-face :face-bg nil :blend 0.3)))


;;
;;; Magit
(after! magit
  (setq magit-inhibit-save-previous-winconf t  ; Avoids jarring window configuration jumps on quit
        evil-collection-magit-want-horizontal-movement t
        transient-values '((magit-rebase "--autosquash" "--autostash")
                           (magit-pull "--rebase" "--autostash")
                           (magit-revert "--autostash"))))
