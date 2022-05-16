(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(electric-pair-mode 1)
(setq ring-bell-function 'ignore)
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
								term-mode-hook
								eshell-mode-hook
								shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq-default tab-width 2)

;; Revert buffer on f5
(global-set-key (kbd "<f5>") 'revert-buffer)

;; Move customs to another location
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Font
(set-face-attribute 'default nil :font "Ubuntu Mono" :height 130)

;; Init package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
												 ("org" . "https://orgmode.org/elpa/")
												 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Init use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Ivy (auto-completion)
(use-package swiper)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
				 :map ivy-minibuffer-map
				 ("TAB" . ivy-alt-done)
				 ("C-l" . ivy-alt-done)
				 ("C-j" . ivy-next-line)
				 ("C-k" . ivy-previous-line)
				 :map ivy-switch-buffer-map
				 ("C-k" . ivy-previous-line)
				 ("C-l" . ivy-done)
				 ("C-d" . ivy-switch-buffer-kill)
				 :map ivy-reverse-i-search-map
				 ("C-k" . ivy-previous-line)
				 ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

;; Easily open buffer switcher
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command so that mode line icons
;; display correctly
;;
;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

;; Extra (doom) themes
(use-package doom-themes)

(load-theme 'doom-dark+ t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
				 ("C-x b" . counsel-ibuffer)
				 ("C-x C-f" . counsel-find-file)
				 :map minibuffer-local-map
				 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

;; Typescript
(use-package typescript-mode)

;; Go
(use-package go-mode)

;; Company mode, enabled always
(use-package company
  :hook (after-init . global-company-mode))
