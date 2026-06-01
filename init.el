(load "~/.emacs.d/config.el")
(load "~/.emacs.d/clock.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-babel-load-languages '((emacs-lisp . t) (C . t) (scheme . t)))
 '(package-selected-packages
   '(copilot systemd pdf-tools auctex haskell-mode org org-reverse-datetree zzz-to-char helm-org-rifle dts-mode org-alert company forge ivy magit magit-gitlab magit-lfs treemacs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:weight bold :height 1.3))))
 '(org-level-2 ((t (:weight semi-bold :height 1.15))))
 '(org-level-3 ((t (:weight normal :height 1.05)))))
(org-babel-do-load-languages
 'org-babel-load-languages '((C . t) (shell . t)))
