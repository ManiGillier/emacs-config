
(setq split-width-threshold 60)
(setq split-height-threshold 50)
(setq split-window-preferred-function 'split-window-sensibly)
(setq pop-up-frames nil)

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

(defun kill-buffer-quick ()
  (interactive)
  (kill-buffer nil))

(keymap-global-set "C-k" 'kill-buffer-quick)
;; Similar to "C-_" (undo)
(keymap-global-set "C-x _" 'revert-buffer-quick)
(keymap-global-set "<f5>" 'org-agenda-a)
(keymap-global-set "<f6>" 'org-agenda-notes)
(keymap-global-set "<f7>" 'org-agenda)
(keymap-global-set "<f8>" 'magit-status)
(keymap-global-set "C-x C-b" 'ibuffer)
(keymap-global-set "M-o" 'other-window)
(keymap-global-set "C-o" 'other-window)
(keymap-global-set "M-<backspace>" 'delete-window)
(keymap-global-set "C-x t" 'treemacs)
(keymap-global-set "M-p" 'switch-to-buffer)

(keymap-global-set "C-s-<XF86TouchpadOff>" 'other-window)
(keymap-global-set "s-<XF86TouchpadOff>" 'delete-window)
(keymap-global-set "C-v" 'switch-to-next-buffer)

(require 'eglot)
(global-set-key [C-mouse-1] 'xref-find-definitions-at-mouse)
(global-set-key [C-down-mouse-1] nil)
(global-set-key [C-mouse-3] 'xref-pop-marker-stack)
(global-set-key [C-down-mouse-3] nil)
; (keymap-global-unset "C-<mouse-1>")
; (keymap-global-unset "C-<down-mouse-1>")
; (keymap-global-unset "C-<mouse-3>")
; (keymap-global-unset "C-<down-mouse-3>")

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

(require 'org-alert)
(setq alert-default-style 'libnotify)

(require 'helm-org-rifle)

;; Server

(server-start)

;; Mails sending

(setq user-full-name "Mani Gillier")
(setq user-mail-address "mani@gillier.dev")
(setq smtpmail-smtp-server "smtp.mail.ovh.net"
      smtpmail-smtp-service 465
      smtpmail-stream-type 'ssl)
(setq send-mail-function 'smtpmail-send-it)

;; AI

(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion)))
