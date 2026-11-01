;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; DO NOT EDIT THIS CONFIG. IT'S AUTO TANGLED FROM README.ORG
;; EDIT README.ORG INSTEAD

(package! evil-xkbswitch
  :recipe (:host github :repo "linktohack/evil-xkbswitch"))

(package! reverse-im
  :recipe (:host github :repo "a13/reverse-im.el"))

(package! org-auto-tangle)

(package! org-modern)

(package! org-modern-indent
  :recipe (:host github :repo "jdtsmith/org-modern-indent"))

(package! org-appear)

(package! org-download)

(package! org-roam)
(unpin! org-roam)

(package! org-roam-ui)

(package! org-yt
  :recipe (:host github :repo "TobiasZawada/org-yt"))
(package! org-excalidraw
  :recipe (:host github :repo "andrewpeck/org-excalidraw"))

;; (package! org-excalidraw
;;   :recipe (:local-repo "org-excalidraw"
;;            :files ("*.el")))

(package! org-present)

(package! dired-single)
(package! dired-subtree)

(package! dired-preview)

(package! all-the-icons-dired)

(package! dired-open)

(package! dirvish)
