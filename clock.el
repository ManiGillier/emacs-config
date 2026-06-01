;; ============================================================
;; ORG CORE SETUP
;; ============================================================

(setq org-default-notes-file "~/org/inbox.org")
(setq org-startup-indented t)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)
(setq org-agenda-files
      '("~/org/inbox.org"
        "~/org/tasks.org"
        "~/org/journal.org"
        "~/org/notes.org"
        "~/org/debugging.org"))

(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-refile-targets
      '((org-agenda-files :maxlevel . 3)))

(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)

(setq org-return-follows-link t)
(setq org-startup-indented t)
(setq org-startup-with-inline-images t)
(setq org-cycle-separator-lines 1)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-use-speed-commands t)

;; TODO workflow
(setq org-todo-keywords
      '((sequence "TODO(t)" "BLOCKED(b)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("BLOCKED" . (:foreground "red" :weight bold))
        ("DONE" . (:foreground "green4" :weight normal))
        ("CANCELLED" . (:foreground "gray50" :strike-through t))))

;; Tags
(setq org-tag-alist
      '(("debug" . ?d)
        ("kernel" . ?k)
        ("hw" . ?h)
        ("logs" . ?l)
        ("note" . ?n)
        ("experiment" . ?e)))
(setq org-tag-faces
      '(("debug" . (:foreground "gray60"))
        ("kernel" . (:foreground "gray60"))
        ("hw" . (:foreground "gray60"))
        ("logs" . (:foreground "gray60"))
        ("note" . (:foreground "firebrick4"))
        ("experiment" . (:foreground "gray60"))))

(setq org-hide-leading-stars t)
(setq org-indent-mode-turns-on-hiding-stars t)
(setq org-use-speed-commands t)

(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t")
        (todo . " %i %-12:c")
        (tags . " %i %-12:c")))

(setq org-agenda-use-tag-inheritance nil)
(setq org-use-tag-inheritance nil)

;; ============================================================
;; CLOCKING (TIME TRACKING)
;; ============================================================

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(setq org-clock-out-when-done t)
(setq org-clock-in-resume t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-idle-time 15)
(setq org-clock-continuously nil)
(setq org-log-refile nil)
(setq org-clock-report-include-clocking-task t)

;; ============================================================
;; DYNAMIC CAPTURE TARGET (CLOCK-AWARE CHILD SYSTEM)
;; ============================================================

(defun my/org-dynamic-target ()
  "Capture under currently clocked task if active, otherwise inbox."
  (if (org-clocking-p)
      (list 'clock)
    (list 'file "~/org/inbox.org")))

;; ============================================================
;; HELPER FUNCTIONS
;; ============================================================

(defun my/insert-timestamp ()
  (interactive)
  (insert (format-time-string "%H:%M:%S.%3N")))

(global-set-key (kbd "C-t") 'my/insert-timestamp)

;; WARNING: overrides default scroll-up-command
(global-set-key (kbd "C-v") 'org-capture)

;; ============================================================
;; CAPTURE TEMPLATES
;; ============================================================

(setq org-capture-templates
      '(
        ;; ----------------------------------------------------
        ;; INBOX
        ;; ----------------------------------------------------
        ("i" "Inbox" entry
         (file "~/org/inbox.org")
         "* TODO %?\n%U\n")

        ;; ----------------------------------------------------
        ;; TASK
        ;; ----------------------------------------------------
        ("t" "Task" entry
         (file "~/org/tasks.org")
         "* TODO %?\n%U\n%a\n")

        ;; ----------------------------------------------------
        ;; TASK
        ;; ----------------------------------------------------
        ("n" "Note" entry
         (file+olp+datetree "~/org/notes.org")
         "* %? :note:\n%T\n"
	 :tree-type (year)
	 :prepend t
	 :jump-to-captured t)

        ;; ----------------------------------------------------
        ;; JOURNAL
        ;; ----------------------------------------------------
        ("j" "Daily Journal" entry
         (file+olp+datetree "~/org/journal.org")
         "* JOURNAL %<%A %d/%m> :journal:\n%?\nEntered on %U\n\n** Work Done\n\n** Report\n\n** Key Learnings\n\n** Next Steps\n"
	 :clock-in t
	 :clock-keep t
	 :jump-to-captured t
	 :tree-type (year)
	 :prepend t)

        ;; ----------------------------------------------------
        ;; BUG TRACKING
        ;; ----------------------------------------------------
        ("B" "Bug (long-term)" entry
         (file "~/org/debugging.org")
         "* BUG %^{Title} :bug:\n%U\n\n** Summary\n%?\n\n** Symptoms\n\n** Conditions\n\n** Linked Experiments\n\n** Current Understanding\n\n** Open Questions\n"
	 :clock-in t
	 :clock-keep t)

        ;; ----------------------------------------------------
        ;; EXPERIMENT (CLOCK-AWARE)
        ;; ----------------------------------------------------
        ("e" "Experiment")
	("en" "New experiment" entry
         (file "~/org/debugging.org")
         "* EXPERIMENT %^{Title} :experiment:kernel:\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?\n** Objective\n\n\n** Hypothesis\n\n** Test Procedure\n\n** Expected Result\n\n** Result\n\n** Timeline (Reconstruction)\n| Time | Source | Event | Notes |\n|------|--------|--------|--------|\n|0||||\n|||||\n#+TBLFM: @3$0..$0 = @-1 + 1\n\n** Conclusion\n\n** Next Step\n"
         :clock-in t
         :clock-keep t
	 :jump-to-captured t
	 :prepend t)

        ;; ========================================================
        ;; CHILD CAPTURES (CLOCK-AWARE DEBUGGING BLOCKS)
        ;; ========================================================

        ("ed" "dmesg" entry
         (clock)
         "** DMESG :logs:\n%U\n\n#+BEGIN_SRC sh :results raw :wrap ASCII$\nssh core 'dmesg | grep anx | tail -n 200'\n#+END_SRC%?\n\n\n\n*** Timeline Marker\n- Time:\n- Event:\n"
	 :jump-to-captured t)

        ("er" "Register Dump" entry
         (clock)
         "** REGISTER DUMP :reg:hw:\n%U\n\n*** Interface\n- Bus:\n- Address:\n\n*** Output\n**** 0x28 (0x50)\n#+BEGIN_SRC sh :results raw :wrap export ascii\nssh core 'i2cdump -f -y 1 0x28 b'\n#+END_SRC\n%?\n**** 0x2c (0x58)\n#+BEGIN_SRC sh :results raw :wrap export ascii\nssh core 'i2cdump -f -y 1 0x2c b'\n#+END_SRC\n%?\n*** Timeline Marker\n- Time:\n- Change:\n"
	 :jump-to-captured t)

        ("eo" "Observation" entry
         (clock)
         "** OBSERVATION :observation:\n%U\n\n*** Scenario\n%?\n\n*** What Happened\n\n*** Expected\n\n*** Timeline Marker\n- Time:\n- Visible event:\n"
	 :jump-to-captured t)

        ("eg" "GPIO / IRQ" entry
         (clock)
         "** GPIO / IRQ :gpio:irq:\n%U\n\n*** Pins\n\n*** Event\n\n*** Logs\n#+BEGIN_SRC\n%?\n#+END_SRC\n\n*** Timeline Marker\n- Time:\n- Interrupt:\n"
	 :jump-to-captured t)

        ("eu" "ANX7688 UART" entry
         (clock)
         "** UART LOG :uart:anx7688:\n%U\n\n*** Context\n- Cable:\n- Role:\n\n*** Log\n#+BEGIN_SRC\n%?\n#+END_SRC\n\n*** Key Events\n\n*** Timeline Marker\n- Time:\n- UART event:\n"
	 :jump-to-captured t)

        ("es" "Saleae Capture" entry
         (clock)
         "** SALEAE CAPTURE :saleae:logic:\n%U\n\n*** Info\n- Channels:\n- Sample rate:\n- Trigger:\n\n*** File\n[[file:%^{Path to .sal file}]]\n\n*** Observations\n\n*** Correlation\n- Kernel:\n- UART:\n\n*** Timeline Marker\n- Time zero:\n- Event:\n"
	 :jump-to-captured t)
        ))

;; ============================================================
;; AGENDA SHORTCUTS
;; ============================================================

(defun my/journal ()
  (interactive)
  (org-capture nil "j"))
(defun my/experiment ()
  (interactive)
  (org-capture nil "en"))

(defun org-agenda-journal ()
  (interactive)
  (org-agenda nil "j"))
(defun org-agenda-debug ()
  (interactive)
  (org-agenda nil "D"))
(defun org-agenda-clock ()
  (interactive)
  (org-agenda nil "c"))
(defun org-agenda-day ()
  (interactive)
  (org-agenda nil "d"))

(keymap-global-set "<f2>" 'my/journal)
(keymap-global-set "<f3>" 'my/experiment)
(keymap-global-set "<f4>" 'org-agenda-journal)
(keymap-global-set "<f5>" 'org-agenda-debug)
(keymap-global-set "<f6>" 'org-agenda-day)
(keymap-global-set "<f7>" 'org-agenda)
(keymap-global-set "<f9>" 'org-agenda-clock)
(keymap-global-set "<home>" 'org-clock-in)
(keymap-global-set "C-<home>" 'org-clock-out)

;; ============================================================
;; EXPORT SETTINGS
;; ============================================================

(use-package ox-md
  :config
  (setq org-md-emphasis-alist
        '((bold . "**")
          (italic . "*")
          (underline . "__")
          (strike-through . "~~")))
  (setq org-md-code-blocks 'fenced)
  (setq org-md-export-properties '("ID" "CATEGORY" "CUSTOM_ID")))

(setq org-agenda-custom-commands
      '(
        ;; ====================================================
        ;; DAILY OPERATING VIEW
        ;; ====================================================
        ("d" "Daily View"
         (
          (agenda ""
                  ((org-agenda-span 1)
                   (org-agenda-start-day nil)
                   (org-agenda-overriding-header "Today")))

          (todo "TODO"
                ((org-agenda-overriding-header "Active Tasks")
                 (org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'scheduled 'deadline))))

          (todo "EXPERIMENT"
                ((org-agenda-overriding-header "Engineering Work")))

          (tags "note"
                ((org-agenda-overriding-header "Notes")))
	  ))

        ;; ====================================================
        ;; DEBUGGING WORKSPACE VIEW
        ;; ====================================================
        ("D" "Debugging Workspace"
         (
          (todo "EXPERIMENT"
                ((org-agenda-overriding-header "Active Investigations")))
          (todo "BUG"
                ((org-agenda-overriding-header "Bugs")))
          (todo "BLOCKED_EXPERIMENT"
                ((org-agenda-overriding-header "Blocked Investigations")))
          (tags "logs"
                ((org-agenda-overriding-header "Log Activity")))
          ))

        ;; ====================================================
        ;; CLOCK-CENTERED VIEW
        ;; ====================================================
        ("c" "Clock Focus"
         (
          (agenda ""
                  ((org-agenda-span 1)
                   (org-agenda-start-with-clockreport t)
                   (org-agenda-overriding-header "Current Day and Clock Data")))
         ))

        ;; ====================================================
        ;; INBOX PROCESSING
        ;; ====================================================
        ("i" "Inbox Review"
         (
          (todo "TODO"
                ((org-agenda-files '("~/org/inbox.org"))
                 (org-agenda-overriding-header "Inbox Items")))
         ))

        ;; ====================================================
        ;; EXPERIMENT TRACKING
        ;; ====================================================
        ("e" "Experiments"
         (
          (todo "EXPERIMENT"
                ((org-agenda-overriding-header "Experiments")))
          (todo "BLOCKED_EXPERIMENT"
                ((org-agenda-overriding-header "Blocked experiments")))
          (todo "DONE_EXPERIMENT"
                ((org-agenda-overriding-header "Done experiments")))
         ))

        ;; ====================================================
        ;; JOURNALS TRACKING
        ;; ====================================================
        ("j" "Journals"
         (
          (todo "JOURNAL"
                ((org-agenda-overriding-header "Journals")))
         ))
	))
