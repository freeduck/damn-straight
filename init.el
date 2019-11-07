;; https://www.emacswiki.org/emacs/DeadKeys
;; <dead_tilde> is undefined
(setq custom-file "~/.emacs-custom.el")
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(require 'iso-transl)
;; https://www.gnu.org/software/emacs/manual/html_node/tramp/Remote-programs.html
;; Remote PATH keeps stuff from .profile
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'truncate-lines t)

(setq straight-process-buffer "*stright-output*")
;; start straight
(load (concat (file-name-as-directory user-emacs-directory)
		 (file-name-as-directory "upstream")
		 "bootstrap.el"))
(straight-use-package 'use-package)

;; Completion
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
  (global-set-key (kbd "C-c a") 'counsel-ag)
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
  :config
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package better-defaults
  :straight t
  :after ivy)


(use-package epkg
  :straight t)

;; (use-package chocolate-theme
;;   :straight (:host github :repo "SavchenkoValeriy/emacs-chocolate-theme"
;;              :branch "master")
;;   :config
;;   (load-theme 'chocolate t))
(use-package cyberpunk-2019-theme
  :straight t)
(load-theme 'deeper-blue)

(use-package org
  :straight org-plus-contrib)

(use-package ggtags
  :straight t)

(use-package  which-key
  :straight t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right))
;; end completion

;; (use-package projectile
;;   :straight t
;;   :bind-keymap
;;   ("C-c p" . projectile-command-map)
;;   :init
;;   (setq projectile-completion-system 'ivy)
;;   :config
;;   (projectile-mode +1))

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

(use-package outshine
  :straight t)

;; (use-package godot-gdscript
;;   :straight t)

(use-package markdown-mode
  :straight t
  :config
  (add-hook 'markdown-mode-hook (lambda () (flyspell-mode 1))))

(use-package terraform-mode
  :straight t)

;; https://github.com/bbatsov/emacs.d/blob/master/init.el
(use-package paredit
  :straight t
  :config
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  ;; enable in the *scratch* buffer
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'ielm-mode-hook #'paredit-mode)
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode))

(use-package rainbow-delimiters
  :straight t)

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
;; racket
(use-package racket-mode
  :straight t
  :config
  (add-hook 'racket-mode-hook #'paredit-mode)
  (add-hook 'racket-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'racket-mode-hook (lambda () (flyspell-prog-mode)))
  (add-hook 'racket-mode-hook 'outshine-mode))

(use-package ob-racket
  :straight (ob-racket :host github
		       :repo "hasu/emacs-ob-racket"
		       :branch "master")
  :commands (org-babel-execute:racket
             org-babel-expand-body:racket))

;; golang
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

(use-package groovy-mode
  :straight t)

(use-package dockerfile-mode
  :straight t)

(use-package ace-window
  :straight t
  :config
  (global-set-key (kbd "s-w") 'ace-window)
  (global-set-key [remap other-window] 'ace-window))

(use-package docker-tramp
  :straight t)

(use-package slime
  :straight t
  :commands (slime)
  :init
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy)))
