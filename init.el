;; * Damn straight
(setq custom-file "~/.emacs-custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/bookmarkplus")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; ** Deadkeys
;; https://www.emacswiki.org/emacs/DeadKeys
;; <dead_tilde> is undefined
(require 'iso-transl)
;; ** Tramp
;; https://www.gnu.org/software/emacs/manual/html_node/tramp/Remote-programs.html
;; Remote PATH keeps stuff from .profile
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(server-start)
;; ** Better defaults
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(run-at-time nil (* 5 60) 'recentf-save-list)
;; ** Filesets
(filesets-init)
(global-set-key (kbd "C-c m f e") 'filesets-edit)
(run-at-time nil (* 5 60) 'filesets-save-config)
(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'truncate-lines t)

(blink-cursor-mode -1)
(setq inhibit-startup-screen t)
(global-auto-revert-mode t)
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))
(progn
  (unless (eq window-system 'ns)
    (menu-bar-mode -1))
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
  (when (fboundp 'horizontal-scroll-bar-mode)
    (horizontal-scroll-bar-mode -1))

  (autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR." t)

  (require 'saveplace)
  (setq-default save-place t)

  (global-set-key (kbd "M-/") 'hippie-expand)
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (global-set-key (kbd "M-z") 'zap-up-to-char)

  (show-paren-mode 1)
  (setq-default indent-tabs-mode nil)
  (setq save-interprogram-paste-before-kill t
        apropos-do-all t
        mouse-yank-at-point t
        require-final-newline t
        visible-bell t
        load-prefer-newer t
        ediff-window-setup-function 'ediff-setup-windows-plain
        save-place-file (concat user-emacs-directory "places")
        backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups"))))

  (global-set-key (kbd "C-x t c a") 'tramp-cleanup-all-connections))


;; ** start straight
(setq straight-process-buffer "*stright-output*")
(load (concat (file-name-as-directory user-emacs-directory)
		 (file-name-as-directory "upstream")
		 "bootstrap.el"))
(straight-use-package 'use-package)

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*")
  (setq uniquify-min-dir-content 2))

(use-package epkg
  :straight t)
;; ** Enhancements
(use-package  which-key
  :straight t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right))
;; (setq outline-minor-mode-prefix "\M-#")
(use-package outshine
  :straight t
  :init
  (defvar outline-minor-mode-prefix "\M-#")
  :config
  (add-hook 'prog-mode-hook #'outshine-mode))
;; https://github.com/bbatsov/emacs.d/blob/master/init.el
;; (use-package paredit
;;   :straight t
;;   ;; :hook prog-mode
;;   :config
;;   ;; (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
;;   (add-hook 'prog-mode-hook #'paredit-mode)
;;   ;; enable in the *scratch* buffer
;;   (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
;;   (add-hook 'ielm-mode-hook #'paredit-mode)
;;   (add-hook 'lisp-mode-hook #'paredit-mode)
;;   (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode))
(use-package smartparens
  :straight t
  :init
  (progn
    (use-package smartparens-config)
    (use-package smartparens-ruby)
    (use-package smartparens-html)
    (smartparens-global-mode 1)
    (show-smartparens-global-mode 1))
  :config
  (progn
    (setq smartparens-strict-mode t)
    (sp-local-pair 'emacs-lisp-mode "`" nil :when '(sp-in-string-p)))
  :bind
  (("C-M-k" . sp-kill-sexp-with-a-twist-of-lime)
   ("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-n" . sp-up-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-M-u" . sp-backward-up-sexp)
   ("C-M-p" . sp-backward-down-sexp)
   ("C-M-w" . sp-copy-sexp)
   ("M-s" . sp-splice-sexp)
   ("M-r" . sp-splice-sexp-killing-around)
   ("C-)" . sp-forward-slurp-sexp)
   ("C-}" . sp-forward-barf-sexp)
   ("C-(" . sp-backward-slurp-sexp)
   ("C-{" . sp-backward-barf-sexp)
   ("M-S" . sp-split-sexp)
   ("M-J" . sp-join-sexp)
   ("C-M-t" . sp-transpose-sexp)))

(use-package rainbow-delimiters
  :straight t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package crux
  :straight t
  :bind (("C-c o" . crux-open-with)
         ("M-o" . crux-smart-open-line)
         ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-c f" . crux-recentf-find-file)
         ("C-M-z" . crux-indent-defun)
         ("C-c u" . crux-view-url)
         ("C-c e" . crux-eval-and-replace)
         ("C-c w" . crux-swap-windows)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-c r" . crux-rename-buffer-and-file)
         ("C-c t" . crux-visit-term-buffer)
         ("C-c k" . crux-kill-other-buffers)
         ("C-c TAB" . crux-indent-rigidly-and-copy-to-clipboard)
         ("C-c I" . crux-find-user-init-file)
         ("C-c S" . crux-find-shell-init-file)
         ("s-r" . crux-recentf-find-file)
         ("s-j" . crux-top-join-line)
         ("C-^" . crux-top-join-line)
         ("s-k" . crux-kill-whole-line)
         ("C-<backspace>" . crux-kill-line-backwards)
         ("s-o" . crux-smart-open-line-above)
         ([remap move-beginning-of-line] . crux-move-beginning-of-line)
         ([(shift return)] . crux-smart-open-line)
         ([(control shift return)] . crux-smart-open-line-above)
         ([remap kill-whole-line] . crux-kill-whole-line)
	 ("C-c s" . crux-ispell-word-then-abbrev)))
(use-package ace-window
  :straight t
  :config
  (global-set-key (kbd "s-w") 'ace-window)
  (global-set-key [remap other-window] 'ace-window))
;; ** Completion
(use-package ivy
  :straight t
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

;; https://github.com/bbatsov/emacs.d/blob/master/init.el
(use-package counsel
  :straight t
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  ;; (global-set-key (kbd "C-c a") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))
;; (use-package counsel
;;   :straight t
;;   :)
;; ;; counsel-M-x

(use-package counsel-projectile
  :straight t
  :after projectile
  :config
  (counsel-projectile-mode))



(use-package company
  :straight t
  :hook
  (after-init . global-company-mode)
  :bind (:map company-active-map
     ("C-n" . company-select-next-or-abort)
     ("C-p" . company-select-previous-or-abort))
  :config
  (setq company-tooltip-flip-when-above t))

(use-package ggtags
  :straight t)

;; ** Project management
(use-package bookmark+)
(use-package dired+)
(use-package projectile
  :straight t
  :after ivy
  :init
  (setq projectile-completion-system 'ivy)
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
(use-package magit
  :straight t
  :bind (("C-x g" . magit-status)))

(use-package git-timemachine
  :straight t)
;; ** Theming
(use-package chocolate-theme
  :straight (:host github :repo "SavchenkoValeriy/emacs-chocolate-theme"
                   :branch "master")
  :defer t)

(use-package cyberpunk-2019-theme
  :straight t
  :defer t)

(use-package cyberpunk-theme
  :straight t
  :defer t)

(use-package solarized-theme
  :straight t
  :defer t)

(use-package zenburn-theme
  :straight t
  :defer t)

(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-acario-dark t))

;; ** Orgmode
(use-package org
  :config
  (require 'org-id)
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-agenda-files (list "~/org/gtd/inbox.org"
                               "~/org/gtd/gtd.org"
                               "~/org/gtd/tickler.org"
                               org-default-notes-file))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-refile-targets '(("~/org/gtd/gtd.org" :maxlevel . 3)
                           ("~/org/gtd/someday.org" :level . 1)
                           ("~/org/gtd/tickler.org" :maxlevel . 2)))
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/org/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/org/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))
  (setq org-id-link-to-org-use-id t)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c l") 'org-store-link))

(use-package ledger-mode
  :straight t)

;; (use-package godot-gdscript
;;   :straight t)
;; ** Markdown
(use-package markdown-mode
  :straight t
  :config
  (add-hook 'markdown-mode-hook (lambda () (flyspell-mode 1))))
(use-package yaml-mode
  :straight t
  :mode (("\\.yaml$" . yaml-mode)
         ("\\.yml$" . yaml-mode)))
;; ** Terraform
(use-package terraform-mode
  :straight t)
;; ** Python
(use-package elpy
  :straight t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i"))
;; ** LISPs
;; *** CL
(use-package slime
  :straight t
  :commands (slime)
  :init
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy)))
;; *** racket
(use-package racket-mode
  :straight t
  :config
  ; (add-hook 'racket-mode-hook #'paredit-mode)
  (add-hook 'racket-mode-hook (lambda () (flyspell-prog-mode))))

(use-package ob-racket
  :straight (ob-racket :host github
		       :repo "hasu/emacs-ob-racket"
		       :branch "master")
  :commands (org-babel-execute:racket
             org-babel-expand-body:racket))

;; ** golang
(use-package go-mode
  :mode "\\.go\\'"
  :straight t)

(use-package company-go
  :straight t
  :after (go-mode company))

(use-package go-projectile
  :straight t
  :after (go-mode projectile))

(use-package go-eldoc
  :straight t
  :after (go-mode))

(use-package gotest
  :straight t
  :after (go-mode))
;; ** clojure


(use-package cider
  :straight t
  :mode ("\\.clj\\'" "\\.cljs\\'"))

(use-package clojure-mode
  :straight t
  :mode ("\\.clj\\'" "\\.cljs\\'"))

;; ** groovy
(use-package groovy-mode
  :straight t)

;; ** docker
(use-package dockerfile-mode
  :straight t)

(use-package docker-tramp
  :straight t)

;; ** Webmode
;; source: https://github.com/glynnforrest/emacs.d/blob/master/site-lisp/setup-web-mode.el
(use-package web-mode
  :straight t
  :mode
  (
   ".twig$"
   ".html?$"
   ".hbs$"
   ".vue$"
   ".blade.php$"
   )
  :config
  (setq
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-enable-auto-closing t
   web-mode-enable-auto-opening t
   web-mode-enable-auto-pairing t
   web-mode-enable-auto-indentation t
))
