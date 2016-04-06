(defvar font-face-mono "DejaVu Sans Mono Book")
(defvar font-face-sans "Lato")

(defvar font-size-low-dpi    10)
(defvar font-size-medium-dpi 13)

(defvar font-size
  (if (string= system-name "renzo")
      font-size-medium-dpi
      font-size-low-dpi))

(defvar font-mono
  (concat font-face-mono " " (number-to-string font-size)))
(defvar font-sans
  (concat font-face-sans " " (number-to-string font-size)))

(defun font-setup ()
  (progn
    (add-to-list 'default-frame-alist `(font . ,font-mono))
    (set-face-attribute 'default t :font font-mono)
))

(defun font-neo-setup (window)
  (progn
    (set-face-attribute 'neo-banner-face      nil :font font-sans)
    (set-face-attribute 'neo-button-face      nil :font font-sans)
    (set-face-attribute 'neo-file-link-face   nil :font font-sans)
    (set-face-attribute 'neo-dir-link-face    nil :font font-sans)
    (set-face-attribute 'neo-header-face      nil :font font-sans)
    (set-face-attribute 'neo-expand-btn-face  nil :font font-sans)
    (set-face-attribute 'neo-root-dir-face    nil :font font-sans)
))

(if (not (daemonp))
  (progn
    (font-setup)
    (add-hook 'neo-after-create-hook 'font-neo-setup)
))
