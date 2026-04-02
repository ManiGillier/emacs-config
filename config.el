
(setq split-width-threshold 70)
(setq split-height-threshold 80)
(setq split-window-preferred-function 'split-window-sensibly)
(setq pop-up-frames nil)
(setq org-agenda-files (list "~/org/"))
(setq org-todo-keywords
      '((sequence "TODO(t)" "VERIFY(v!/@!)" "|" "DONE(d!)")))
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-idle-time 5)
(setq org-clock-continuously nil)
(setq org-global-properties '(("Effort_ALL" . "0 0:15 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00")))
(setq org-columns-default-format "%25ITEM %1PRIORITY %EFFORT{:} %CLOCKSUM")
(setq org-log-refile 't)
(setq org-directory "~/org")
(setq org-capture-templates
      '(("t" "Task")
        ("tp" "Task Plan" entry (file+headline "~/org/organization.org" "Tasks")
         "* TODO %?\nSCHEDULED: %^t\n%i\n"
         :clock-keep 't
         )
        ("tn" "Task Now" entry (file+headline "~/org/organization.org" "Tasks")
         "* TODO %?\nSCHEDULED: %t\nINTERRUPTED: %K\n%i\n"
         :clock-in 't
         :clock-keep 't
         )
        ("s" "Subtask" entry (clock)
         "* TODO %?\nSCHEDULE:%t\n%i\n"
         :clock-in 't
         :clock-keep 't
         )
        ("m" "Meeting" entry (file+headline "~/org/organization.org" "Meetings")
         "* %? :meeting:\nSCHEDULED: %^T\n%i\n"
         :clock-keep 't
         :time-prompt 't
         )
        ("n" "Note" entry (file+olp+datetree "~/org/notes.org")
         "* TO-REFINE %? :note:\n%i\n"
         :clock-keep 't
         :time-prompt 't
         )
        ("l" "Learning" entry (file+olp+datetree "~/org/notes.org")
         "* TO-REFINE %? :learning:\n%t\n%i\n"
         :clock-keep 't
         :time-prompt 't
         )
        ))
(setq org-use-sub-superscripts "{}")
(setq org-export-with-sub-superscripts "{}")
(setq desktop-path '("~/"))
(desktop-save-mode 1)

(defun org-agenda-a ()
  (interactive)
  (org-agenda nil "a"))

(defun kill-buffer-quick ()
  (interactive)
  (kill-buffer nil))

(keymap-global-set "C-k" 'kill-buffer-quick)
;; Similar to "C-_" (undo)
(keymap-global-set "C-x _" 'revert-buffer-quick)
(keymap-global-set "<f6>" 'org-agenda)
(keymap-global-set "<f5>" 'org-agenda-a)
(keymap-global-set "<f8>" 'magit-status)
(keymap-global-set "C-x C-b" 'ibuffer)
(keymap-global-set "M-o" 'other-window)
(keymap-global-set "M-<backspace>" 'delete-window)
(keymap-global-set "C-x t" 'treemacs)
(keymap-global-set "M-p" 'switch-to-buffer)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; EGLOT config

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(setq eglot-autoshutdown 't)
(add-hook 'after-init-hook 'global-company-mode)
(ivy-mode 1)

;; Custom agenda

(setq org-agenda-custom-commands
      '(("l" tags "+learning")
	("t" todo "TO-REFINE")
	("n" tags "+note")))

(require 'org-alert)
(setq alert-default-style 'libnotify)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/home/mani/org/notes.org" "/home/mani/org/organization.org"))
 '(package-selected-packages '(company forge ivy magit magit-gitlab magit-lfs treemacs org-alert)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
