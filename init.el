(load-theme 'deeper-blue)
;; https://www.emacswiki.org/emacs/DeadKeys
;; <dead_tilde> is undefined

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(require 'iso-transl)

;; https://www.gnu.org/software/emacs/manual/html_node/tramp/Remote-programs.html
;; Remote PATH keeps stuff from .profile
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; https://github.com/bbatsov/emacs.d/blob/master/init.el
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(setq inhibit-startup-screen t)
(global-auto-revert-mode t)

;; hippie expand is dabbrev expand on steroids
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

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") #'hippie-expand)
(global-set-key (kbd "s-/") #'hippie-expand)

;; start straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

(use-package org
  :straight org-plus-contrib)
(use-package ivy
  :straight t
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))
(use-package counsel
  :straight t)
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
	  :init
	  (setq projectile-completion-system 'ivy)
	  :config
	  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
	  (projectile-mode +1))

;; (use-package godot-gdscript
;;   :straight t)

(use-package company
  :straight t
  :config
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package markdown-mode
  :straight t)

(use-package magit
	  :straight t
	  :bind (("C-x g" . magit-status)))

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
  :straight t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((org-confirm-babel-evaluate)
     (org-use-property-inheritance . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
