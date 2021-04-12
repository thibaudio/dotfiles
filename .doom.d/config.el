;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

; From https://tecosaur.github.io/emacs-config/config.html

; Some defaults
(setq-default
 tab-width 2                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t            ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(delete-selection-mode 1)                         ; Replace selection when inserting text
(global-subword-mode 1)                           ; Iterate through CamelCase words

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

; Windows
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/projectile-find-file))

(setq +ivy-buffer-preview t)

(map! :map evil-window-map
       ;; Navigation
       "<left>"     #'evil-window-left
       "<down>"     #'evil-window-down
       "<up>"       #'evil-window-up
       "<right>"    #'evil-window-right)

(setq-default major-mode 'org-mode)
(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-big-font (font-spec :family "Fira Code" :size 20)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 20))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Nextcloud/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;


;; Packages configuration

;; Set org agenda files
(after! org
  (setq org-agenda-files '("~/Nextcloud/org/todo.org"
                           "~/Nextcloud/org/projects.org"
                           "~/Nextcloud/org/tickler.org"))
  (setq org-capture-templates
        '(("w" "weekly" entry (file "/Users/tbaas/Nextcloud/org/weekly.org")
           "* Weekly review %<%Y%m%d>
** Clean
*** [ ] Desk
*** [ ] Inboxes
** Review
*** [ ] Next action list
*** [ ] Project list - todoist
*** [ ] Current project - org
*** [ ] Calendar
*** [ ] Waiting for
** Reflect
*** Warmup
**** [ ] Read last review
*** What went well this week?
****
*** What should be improved?
****
"
         :file-name "weekly"
         :head "#+title: Weekly reviews"
         :unnarrowed t))
        )
  (map! :leader
        (:prefix ("a" . "agenda")
         :desc "New weekly review" "w" (lambda () (interactive) (org-capture nil "w")))))

(after! magit
  (magit-delta-mode +1))

(after! org-roam
  (setq org-roam-directory "~/Nextcloud/org/notes")
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "websites/${slug}"
           :head "#+ROAM_KEY: ${ref}
#+TITLE: ${title}
#+roam_tags: Resonance Website

- source :: ${ref}"

           :unnarrowed t)))
  (map! :leader
        :prefix "n"
        :desc "New fleeting note" "j" #'org-roam-dailies-capture-today
        :desc "Today's fleeting notes" "t" #'org-roam-dailies-find-today
        :desc "Find note file" "f" #'org-roam-find-file
        :desc "New note" "n" #'org-roam-capture
        :desc "Insert note link" "i" #'org-roam-insert
        :desc "Search note" "s" (lambda () (interactive) (counsel-rg "" org-roam-directory) )))

(after! org)

(after! lsp-java
  (setq lsp-java-java-path "/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/bin/java"))

(setq lsp-rust-server 'rust-analyzer)

(after! magit
  (setq magit-git-executable "/usr/bin/git"))
