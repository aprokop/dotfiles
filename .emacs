;; .emacs

;; hide welcome screen
(setq inhibit-startup-message t)

;; disable loading of "default.el" at startup
(setq inhibit-default-init t)

; color scheme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-billw)

;; vi like keys
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; set cursor: nonblinking yellow
(blink-cursor-mode 0)
(set-cursor-color "#ffff00")

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
(setq require-final-newline 'query)

;; CJK utf-8 support for non-Asian users
;; (require 'un-define)

;; define default font
; (set-face-attribute 'default nil :font "Comic Sans MS")
(set-face-attribute 'default nil :font "Terminus")
(set-face-attribute 'default nil :height 140)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))     ;; one line at a time
(setq mouse-wheel-progressive-speed nil)                ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                      ;; scroll window under mouse
(setq scroll-step 1)                                    ;; keyboard scroll one line at a time





;;;
;;; ============================ Org Mode ============================
;;;

; read cloned org-mode repo (which could be easily updated)
(add-to-list 'load-path (expand-file-name "~/code/packages/system/emacs-misc/org-mode/lisp"))

; enable org-mode (this line should be after 'load path with org-mode)
(require 'org)
(require 'org-habit)

; apply org-mode by default for .org, .org_arhive or .txt files
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

; include files from these dirs to agenda automatically
(setq org-agenda-files (quote ("~/.personal/org/")))

; capture mode file
(setq org-default-notes-file "~/.personal/org/refile.org")

; start in indented mode
(setq org-startup-indented t)

; wrap lines
(setq org-startup-truncated nil)

; hide blank lines between headings
(setq org-cycle-separator-lines 0)
; prevent creating blank lines before headings but allow list items to adapt to
; existing blank lines around the items
(setq org-blank-before-new-entry (quote ((heading) (plain-list-item . auto))))

;; set custom key bindings (norang)
; very often
(global-set-key (kbd "<f3>")      'org-agenda)                   ; agenda (one less key than 'C-c a')
(global-set-key "\C-cb"           'org-iswitchb)                 ; switch to org file
(global-set-key (kbd "<f11>")     'org-clock-goto)               ; goto currently clocked item
(global-set-key "\C-cc"           'org-capture)                  ; start capture mode
; often
(global-set-key (kbd "C-<f11>")   'org-clock-in)                 ; clock in a task (show menu with prefix)
;; (global-set-key (kbd "<f9> g")    'gnus)                         ; Gnus (mail)
;; (global-set-key (kbd "<f5>")      'ap/org-todo)                  ; show TODO items for this subtree
;; (global-set-key (kbd "<S-f5>")    'ap/widen)                     ; widen
;; (global-set-key (kbd "<f9> b")    'bbdb)                         ; quick access to bbdb data (adressbook)
(global-set-key (kbd "<f9> c")    'calendar)                     ; calendar access
(global-set-key (kbd "<f9> SPC")  'ap/clock-in-last-task)        ; switch clock back to previously clocked task
(global-set-key "\C-cl"           'org-store-link)               ; store the link for retrieval with 'C-c C-l'
; sometimes
(global-set-key (kbd "<f8>")      'org-cycle-agenda-files)       ; goto next org file in org-agenda-files
;; (global-set-key (kbd "<f9> t")    'ap/insert-inactive-timestamp) ; insert inactive timestamp
(global-set-key (kbd "<f9> v")    'visible-mode)                 ; toggle visible modes (for showing/editing links)
(global-set-key (kbd "C-<f9>")    'previous-buffer)              ; previous buffer
(global-set-key (kbd "C-<f10>")   'next-buffer)                  ; next buffer
(global-set-key (kbd "C-x n r")   'narrow-to-region)             ; narrow to region
(global-set-key (kbd "<f9> I")    'ap/punch-in)                  ; punch clock in
(global-set-key (kbd "<f9> O")    'ap/punch-out)                 ; punch clock out
;; (global-set-key (kbd "<f9> o")    'ap/make-org-scratch)          ; switch to org scratch buffer
;; (global-set-key (kbd "<f9> s")    'ap/switch-to-scratch)         ; switch to scratch buffer
; rarely
;; (global-set-key (kbd "<f9> h")    'ap/hide-other)                ; hide all other tasks
(global-set-key (kbd "<f7>")      'ap/set-truncate-lines)        ; toggle line truncation/wrap
(global-set-key "\C-ca"           'org-agenda)                   ; agenda (minimal emacs testing)

;; flyspell mode for spell checking everywhere
; (add-hook 'org-mode-hook 'turn-on-flyspell 'append)             ; should work but does not

;; disable C-c [ and C-c ] and C-c ; in org-mode
(add-hook 'org-mode-hook
          '(lambda ()
             ;; undefine C-c [ and C-c ] since this breaks my
             ;; org-agenda files when directories are include It
             ;; expands the files in the directories individually
             (org-defkey org-mode-map "\C-c["    'undefined)
             (org-defkey org-mode-map "\C-c]"    'undefined)
             (org-defkey org-mode-map "\C-c;"    'undefined))
          'append)

;; setup drawers
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))             ; separate drawers for clocking and logs
(setq org-log-into-drawer t)
(setq org-clock-into-drawer t)                                  ; save clock data and state changes and notes in the LOGBOOK drawer

;; set face attributes
(set-face-attribute 'org-column nil
                     :background "black"
                    )
(set-face-attribute 'org-agenda-clocking nil
                    :background "firebrick"
                    )

;; setup tags
; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@comp"    . ?c)
                            ("@home"    . ?h)
                            ("@work"    . ?w)
                            ("@online"  . ?o)
                            ("@printer" . ?p)
                            ("errand"   . ?e)
                            ("mail"     . ?m)
                            ("call"     . ?c)
                            ("talk"     . ?t)
                            (:endgroup)
                            ("WAITING"  . ?W)
                            ("NOTE"     . ?N))))
; allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))
; for tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)

;; setup <todo> states
(setq org-use-fast-todo-selection t)                            ; allow change from any to any
(setq org-treat-S-cursor-todo-selection-as-state-change nil)    ; skip normal processing when entering/leaving <todo> state
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "|" "PHONE" "MEETING"))))
(setq org-todo-keyword-faces
      (quote (("TODO"       :foreground "red"           :weight bold)
              ("NEXT"       :foreground "orange"        :weight bold)
              ("DONE"       :foreground "forest green"  :weight bold)
              ("WAITING"    :foreground "cyan"          :weight bold)
              ("MEETING"    :foreground "forest green"  :weight bold)
              ("PHONE"      :foreground "forest green"  :weight bold))))
(setq org-todo-state-tags-triggers
      (quote (("WAITING"    ("WAITING" . t))
              (done         ("WAITING"    ))
              ("TODO"       ("WAITING"    )         ("CANCELLED"))
              ("NEXT"       ("WAITING"    )         ("CANCELLED"))
              ("DONE"       ("WAITING"    )         ("CANCELLED")))))

;; capture templates for: <todo> tasks, notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/.personal/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("n" "note" entry (file "~/.personal/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "journal" entry (file+datetree "~/.personal/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("m" "meeting" entry (file "~/.personal/org/refile.org")
               "* MEETING with %? on %t :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "phone call" entry (file "~/.personal/org/refile.org")
               "* PHONE with %? on %t :PHONE:\n%U" :clock-in t :clock-resume t))))

;; remove empty LOGBOOK drawers on clock out
(defun ap/remove-empty-drawer-on-clock-out ()
  (interactive)
    (save-excursion
        (beginning-of-line 0)
            (org-remove-empty-drawer-at "LOGBOOK" (point))))
(add-hook 'org-clock-out-hook 'ap/remove-empty-drawer-on-clock-out 'append)

;; clocking
(org-clock-persistence-insinuate)                                       ; resume clocking task when emacs is restarted
(setq org-clock-history-length 23)                                      ; show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-in-resume t)                                            ; resume clocking task on clock-in if the clock is open
(setq org-clock-in-switch-to-state 'ap/clock-in-to-next)                ; change tasks to NEXT when clocking in
(setq org-clock-out-remove-zero-time-clocks t)                          ; remove clocked tasks with 0:00 duration
(setq org-clock-out-when-done t)                                        ; clock out when moving task to a done state
(setq org-clock-persist t)                                              ; save running clock when exiting Emacs; load it on startup
(setq org-clock-persist-query-resume nil)                               ; do not prompt to resume an active clock
(setq org-clock-auto-clock-resolution
    (quote when-no-clock-is-running))                                   ; enable auto clock resolution for finding open clocks
(setq org-clock-report-include-clocking-task t)                         ; include current clocking task in clock reports
(setq ap/keep-clock-running nil)
(setq org-agenda-clockreport-parameter-plist
    (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))   ; Agenda clock report parameters

;; refile
; exclude DONE state tasks from refile targets
(setq org-refile-target-verify-function 'ap/verify-refile-target)

; make targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; use full outline paths for refile targets (we file directly with IDO)
; we need that as multiple projects may have same heading
(setq org-refile-use-outline-path t)

; targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; use the current window when visiting files and buffers with ido
(setq ido-default-file-method     'selected-window)
(setq ido-default-buffer-method   'selected-window)
; use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;; agenda
(setq org-agenda-span 'day)

; do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

; compact the block agenda view
(setq org-agenda-compact-blocks t)

; set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

; global Effort estimate values
; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:10 0:30 1:00 2:00 4:00 8:00 12:00 16:00 24:00 40:00 0:00")
                                    ("STYLE_ALL" . "habit"))))

; custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down priority-up effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'ap/skip-non-projects)
                            (org-agenda-sorting-strategy
                             '(priority-down category-keep))))
                (tags-todo "/!NEXT"
                           ((org-agenda-overriding-header "Project Next Tasks")
                            (org-agenda-skip-function 'ap/skip-projects-and-habits-and-single-tasks)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-todo-ignore-scheduled ap/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines ap/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date ap/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(priority-down todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-WAITING/!"
                           ((org-agenda-overriding-header (if (marker-buffer org-agenda-restrict-begin) "Project Subtasks" "Standalone Tasks"))
                            (org-agenda-skip-function 'ap/skip-project-tasks-maybe)
                            (org-agenda-todo-ignore-scheduled ap/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines ap/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date ap/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "+WAITING/!"
                           ((org-agenda-overriding-header "Waiting and Postponed Tasks")
                            (org-agenda-skip-function 'ap/skip-stuck-projects)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled 'future)
                            (org-agenda-todo-ignore-deadlines 'future)))
                (tags "-REFILE/DONE"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'ap/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil)
              ("r" "Tasks to Refile" tags "REFILE"
               ((org-agenda-overriding-header "Tasks to Refile")
                (org-tags-match-list-sublevels nil)))
              ("n" "Next Tasks" tags-todo "-WAITING/!NEXT"
               ((org-agenda-overriding-header "Next Tasks")
                (org-agenda-skip-function 'ap/skip-projects-and-habits-and-single-tasks)
                (org-agenda-todo-ignore-scheduled ap/hide-scheduled-and-waiting-next-tasks)
                (org-agenda-todo-ignore-deadlines ap/hide-scheduled-and-waiting-next-tasks)
                (org-agenda-todo-ignore-with-date ap/hide-scheduled-and-waiting-next-tasks)
                (org-tags-match-list-sublevels t)
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ("R" "Tasks" tags-todo "-REFILE/!-WAITING"
               ((org-agenda-overriding-header "Tasks")
                (org-agenda-skip-function 'ap/skip-project-tasks-maybe)
                (org-agenda-sorting-strategy
                 '(category-keep))))
              ("p" "Projects" tags-todo "-CANCELLED/!"
               ((org-agenda-overriding-header "Projects")
                (org-agenda-skip-function 'ap/skip-non-projects)
                (org-agenda-sorting-strategy
                 '(category-keep))))
              ("w" "Waiting Tasks" tags-todo "+WAITING/!"
               ((org-agenda-overriding-header "Waiting and Postponed tasks"))
               (org-tags-match-list-sublevels nil))
              ("A" "Tasks to Archive" tags "-REFILE/"
               ((org-agenda-overriding-header "Tasks to Archive")
                (org-agenda-skip-function 'ap/skip-non-archivable-tasks)
                (org-tags-match-list-sublevels nil))))))

;;; functions

;; punch-in/punch-out
(defun ap/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task. If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq ap/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ; we're in the agenda
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (ap/clock-in-organization-task-as-default)))
    ; we are not in the agenda
    (save-restriction
      (widen)
      ; find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (ap/clock-in-organization-task-as-default)))))
(defun ap/punch-out ()
  (interactive)
  (setq ap/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

;; default timing tasks
(defvar ap/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")
(defun ap/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find ap/organization-task-id 'marker)
    (org-clock-in '(16))))
(defun ap/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))
(defun ap/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when ap/keep-clock-running
            (ap/clock-in-default-task)))))))

;;
(defun ap/clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (ap/is-task-p))
      "NEXT")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (ap/is-project-p))
      "TODO"))))

(defun ap/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(defun ap/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))
(defun ap/clock-out-maybe ()
  (when (and ap/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (ap/clock-in-parent-task)))
(add-hook 'org-clock-out-hook 'ap/clock-out-maybe 'append)

(require 'org-id)
(defun ap/clock-in-task-by-id (id)
  "Clock in a task by id"
  (org-with-point-at (org-id-find id 'marker)
    (org-clock-in nil)))
(defun ap/clock-in-last-task (arg)
  "Clock in the interrupted task if there is one
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
         (cond
          ((eq arg 4) org-clock-default-task)
          ((and (org-clock-is-active)
                (equal org-clock-default-task (cadr org-clock-history)))
           (caddr org-clock-history))
          ((org-clock-is-active) (cadr org-clock-history))
          ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
          (t (car org-clock-history)))))
    (widen)
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))

(defun ap/org-todo (arg)
  (interactive "p")
  (if (equal arg 4)
    (save-restriction
      (bh/narrow-to-org-subtree)
      (org-show-todo-tree nil))
    (bh/narrow-to-org-subtree)
    (org-show-todo-tree nil)))

(defun ap/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))
(defun ap/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (ap/find-project-task)
      (if (equal (point) task)
          nil
        t))))
(defun ap/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))
(defun ap/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))
(defun ap/list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)
(defun ap/list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)
(defvar ap/hide-scheduled-and-waiting-next-tasks t)
(defun ap/toggle-next-task-display ()
  (interactive)
  (setq ap/hide-scheduled-and-waiting-next-tasks (not ap/hide-scheduled-and-waiting-next-tasks))
  (when  (equal major-mode 'org-agenda-mode)
    (org-agenda-redo))
  (message "%s WAITING and SCHEDULED NEXT Tasks" (if ap/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))
(defun ap/skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (ap/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))
(defun ap/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  (ap/list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (ap/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))
(defun ap/skip-non-projects ()
  "Skip trees that are not projects"
  (ap/list-sublevels-for-projects-indented)
  (if (save-excursion (ap/skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((and (ap/is-project-p)
                 (marker-buffer org-agenda-restrict-begin))
            nil)
           ((and (ap/is-project-p)
                 (not (marker-buffer org-agenda-restrict-begin))
                 (not (ap/is-project-subtree-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))
(defun ap/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((ap/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))
(defun ap/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((and ap/hide-scheduled-and-waiting-next-tasks
             (member "WAITING" (org-get-tags-at)))
        next-headline)
       ((ap/is-project-p)
        next-headline)
       ((and (ap/is-task-p) (not (ap/is-project-subtree-p)))
        next-headline)
       (t
        nil)))))
(defun ap/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((ap/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (ap/is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (ap/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))
(defun ap/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((ap/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))
(defun ap/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (ap/is-subproject-p)
        nil
      next-headline)))
(defun ap/org-auto-exclude-function (tag)
  "Automatic task exclusion in the agenda with / RET"
  (and (cond
        ((string= tag "hold")
         t)
       (concat "-" tag))))
(setq org-agenda-auto-exclude-function 'ap/org-auto-exclude-function)

(defun ap/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))
