;;; ../dotfiles/.doom.d/org.el -*- lexical-binding: t; -*-
; org-mode related configuration and functions


;; org Configuration
(after! org
  (setq org-agenda-files '("~/Nextcloud/org/gtd/inbox.org" "~/Nextcloud/org/gtd/project.org" "~/Nextcloud/org/gtd/weekly.org"))
  (setq org-capture-templates
        '(("n" "Quick Note" entry (file+headline "~/Nextcloud/org/gtd/inbox.org" "Notes")
           "* %U: %?")
          ("r" "org-capture-protocol" entry (file+headline "~/Nextcloud/org/gtd/inbox.org" "Links")
           "* %:annotation\nCaptured on %U\nurl:: %:link\n%i"
           )
          ("t" "Todo" entry (file+headline "~/Nextcloud/org/gtd/inbox.org" "Todo")
           "* TODO %?\n  %i\n  %a"
           ))
        )
  (map! :leader
        (:prefix ("a" . "agenda")
         :desc "New weekly review" "w" (lambda () (interactive) (find-file "~/Nextcloud/org/gtd/weekly.org")))
        :prefix "n"
        :desc "New quick note" "n" (lambda () (interactive) (org-capture nil "n"))
        :desc "Search note" "s" (lambda () (interactive) (counsel-rg "" "~/Nextcloud/org"))
        :desc "Open inbox" "i" (lambda () (interactive) (find-file "~/Nextcloud/org/gtd/inbox.org"))))

(after! org-roam
  (setq org-roam-directory "~/Nextcloud/org")
  (map! :leader
        :prefix "n"
        :desc "Find note file" "f" #'org-roam-node-find
        :desc "Insert note link" "l" #'org-roam-node-insert
        )
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("m" "meeting" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :Meeting:\n\n* Attendees:\n** \n\n* Context\n\n* Actions")
           :unnarrowed t)
          ))
  )

(provide 'my-org-config)
