;;; ../dotfiles/.doom.d/org.el -*- lexical-binding: t; -*-

; org-mode related configuration and functions


;; Functions
(defun vulpea-agenda-category ()
  "Get category of item at point for agenda.

Category is defined by one of the following items:

- CATEGORY property
- TITLE keyword
- TITLE property
- filename without directory and extension

Usage example:

  (setq org-agenda-prefix-format
        '((agenda . \" %(vulpea-agenda-category) %?-12t %12s\")))

Refer to `org-agenda-prefix-format' for more information."
  (let* ((file-name (when buffer-file-name
                      (file-name-sans-extension
                       (file-name-nondirectory buffer-file-name))))
         (title (vulpea-buffer-prop-get "title"))
         (category (org-get-category)))
    (or (if (and
             title
             (string-equal category file-name))
            title
          category)
        "")))
(defun vulpea-buffer-prop-get (name)
  "Get a buffer property called NAME as a string."
  (org-with-point-at 1
    (when (re-search-forward (concat "^#\\+" name ": \\(.*\\)")
                             (point-max) t)
      (buffer-substring-no-properties
       (match-beginning 1)
       (match-end 1)))))

;; org Configuration
(after! org
  (setq org-capture-templates
        '(("n" "Quick Note" entry (file+headline "~/Nextcloud/org/inbox.org" "Notes")
           "* %U: %?")
          ("r" "org-capture-protocol" entry (file+headline "~/Nextcloud/org/inbox.org" "Links")
           "* %:annotation\nCaptured on %U\nurl:: %:link\n%i"
           ))
        )
  (setq org-agenda-prefix-format
      '((agenda . " %i %-12(vulpea-agenda-category)%?-12t% s")
        (todo . " %i %-12(vulpea-agenda-category) ")
        (tags . " %i %-12(vulpea-agenda-category) ")
        (search . " %i %-12(vaulpea-agenda-category) ")))
  (map! :leader
        (:prefix ("a" . "agenda")
         :desc "New weekly review" "w" (lambda () (interactive) (find-file "~/Nextcloud/org/weekly.org")))
        :prefix "n"
        :desc "New quick note" "n" (lambda () (interactive) (org-capture nil "n"))
        :desc "Search note" "s" (lambda () (interactive) (counsel-rg "" "~/Nextcloud/org"))
        :desc "Open inbox" "i" (lambda () (interactive) (find-file "~/Nextcloud/org/inbox.org"))))

(after! org-roam
  (setq org-roam-directory "~/Nextcloud/org")
  (map! :leader
        :prefix "n"
        :desc "Find note file" "f" #'org-roam-find-file
        :desc "New roam note" "N" #'org-roam-capture
        :desc "Insert note link" "l" #'org-roam-insert
        ))


(provide 'my-org-config)
