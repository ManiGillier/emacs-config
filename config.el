
(setq org-agenda-files (list "~/Personnal/emacs/test/test.org"
			     "~/org/"))
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
        ))
(setq org-use-sub-superscripts "{}")
(setq org-export-with-sub-superscripts "{}")
(setq desktop-path '("~/"))
(desktop-save-mode 1)

(defun org-agenda-a ()
  (interactive)
  (org-agenda nil "a"))

(keymap-global-set "C-k" 'revert-buffer-quick)
(keymap-global-set "<f6>" 'org-agenda)
(keymap-global-set "<f5>" 'org-agenda-a)
(keymap-global-set "<f8>" 'magit-status)
(keymap-global-set "C-x C-b" 'ibuffer)
(keymap-global-set "M-o" 'other-window)
