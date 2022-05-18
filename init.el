;;; package --- Summary
;;; Commentary:
;;; Tridentu's boilerplate Emacs distro
;; Basic Dependencies
(require 'mwheel)
(require 'dired-x)
(require 'package)
;; Modes
(blink-cursor-mode 1)
(xterm-mouse-mode 1)
(mouse-wheel-mode 't)
(electric-pair-mode 1)
;; Fonts
(set-face-attribute 'default t :family "MesloLGS NF")
(set-frame-font "MesloLGS NF 12" nil t)
;; Lists
(add-to-list 'load-path "~/.emacs.d/modules/")
(add-to-list 'load-path "~/.emacs.d/vendor/")
(add-to-list 'load-path "~/.emacs.d/vendor/company-mode")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/themes/"))
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes"))
;; Aliases
(defalias 'yes-or-no-p 'y-or-n-p)
;; More Extras
(require 'company)
(require 'company-c-headers)
(require 'semantic)
;; More Lists
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "/usr/include/c++/10.2.0/")
;; More Modes
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode)
;; Variables
(setq yas-snippet-dirs 	'("~/.emacs.d/snippets"))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs.d/coralmacs/backups")) )
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/coralmacs/autosaves"  t)))
(setq inhibit-startup-screen nil)
(setq ring-bell-function 'ignore)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq dired-dwim-target t)
(setq sentence-end-double-space nil)
(setq frame-title-format "CoralMacs: %b")
(setq initial-scratch-message "Welcome to CoralMacs")
(setq package-enable-at-startup nil)
(setq package-archives '(("org"             . "http://orgmode.org/elpa/")
			 ("gnu"             . "http://elpa.gnu.org/packages/")
			 ("melpa"           . "https://melpa.org/packages/")
	        ))
(setq venv-location "~/python-envs")
;; Packages (Core)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
)
(require 'use-package)
;; Afternoon
(load-theme 'afternoon t)
;; General
(use-package general :ensure t
  :config
  (general-define-key "M-*" 'avy-goto-word-1)
)
(use-package avy :ensure t
  :commands (avy-goto-word-1))
;; Core Packages
;; Other Packages
(use-package ivy :ensure t)
(use-package swiper :ensure t)
(use-package counsel :ensure t)
(general-define-key
 "C-s" 'swiper
 "M-x" 'counsel-M-x
)

(use-package auto-complete :ensure t)
(use-package page-break-lines :ensure t
  :config
  (global-page-break-lines-mode 1)
)
(use-package sublimity :ensure t
  :config
  (require 'sublimity-coralmacs)
  (coralmacs-sublimity-setup-scroll 8 8 )
  (coralmacs-sublimity-setup-map 20 1 -20)
)
(use-package all-the-icons :ensure t)
(use-package projectile :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
)
(use-package which-key :ensure t
  :config
  (which-key-setup-side-window-bottom)
  (which-key-mode)
  (general-define-key
   :prefix "C-c"
   "b"    'ivy-switch-buffer 
   "/"    'counsel-git-grep
   "f"    '(:ignore t :which-key "files")
   "ff"   'counsel-find-file 
   "fr"   'counsel-recentf
   "p"    '(:ignore t :which-key "project")
   "pf"   '(counsel-git :which-key "Find files in a Git repo")
  )
  )
;; Python
(use-package elpy
  :ensure t
  :hook (elpy-mode . (lambda () (set (make-local-variable 'company-backends) '(elpy-company-backend :with company-yasnipet))))
  :init
  (elpy-enable)
  
  )
;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  )
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t
)
(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)
;; Powerline
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  )
;; Origami
(use-package origami :ensure t)
(global-origami-mode +1)
;; Helpful
(use-package helpful :ensure t)
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)

;; Look up *C*ommands.
;;
;; By default, C-h C is bound to describe `describe-coding-system'. I
;; don't find this very useful, but it's frequently useful to only
;; look at interactive functions.
(global-set-key (kbd "C-h C") #'helpful-command)

;; Flycheck
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
)
;; Company
(use-package company
  :ensure t
  :diminish company-mode
  :init
  (global-company-mode)
  :config
  (setq company-backends
	'((company-files
	   company-keywords
	   company-capf
	   company-abbrev
	   company-dabbrev)))
  )

(use-package company-statistics
  :ensure t
  :init
  (company-statistics-mode)
  )

(use-package company-web
  :ensure t)

(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode)
  )
(setq company-quickhelp-color-background "#1c1c1c")
(setq company-quickhelp-color-foreground "#eaeaea")
 '(frame-background-mode 'nil)
 ;; '(hl-sexp-background-color "#1c1f26")

;; Lua
(require 'lua-mode)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
;; Projects
(use-package projectile :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
)
(use-package yasnippet :ensure t
  :config
  (yas-global-mode 1)
  )
(use-package apheleia
  :ensure t)
(apheleia-global-mode +1)

(use-package centaur-tabs :ensure t
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
    :hook
   (dired-mode . centaur-tabs-local-mode)
)
(setq centaur-tabs-style "bar")
(setq centaur-tabs-height 36)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-gray-out-icons 'buffer)
(setq centaur-tabs-set-bar 'over)
(setq centaur-tabs-close-button "X")
(setq centaur-tabs-set-modified-marker t)
(centaur-tabs-change-fonts "Iosevka" 140)
(setq centaur-tabs-cycle-scope 'tabs)
;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-projects-backend 'projectile)
(setq dashboard-banner-logo-title "Welcome to CoralMacs 1.0!")
(setq dashboard-center-content t)

(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-set-init-info t)
(setq dashboard-set-footer nil)
(setq dashboard-init-info "Dive deep into your work!")
(use-package dashboard-ls
  :ensure t)
(setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 10)
			(ls-directories . 5)
			(ls-files . 10)
                       ))
(setq dashboard-item-names '(("Recent Files:" . "Recently opened files:")
                             ("Agenda for today:" . "Today's tasks:")
                             ("Agenda for the coming week:" . "Tasks:")))
;; Semantic Stuff
(semantic-add-system-include "/usr/include/boost" 'c++-mode)
;; Hooks
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (push '(">=" . ?≥) prettify-symbols-alist)))

;; Extra Dependencies
(require 'personaloader)
(coralmacs-load-persona)
