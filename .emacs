(load-file "~/.emacs.d/conf/all.el")

(custom-set-faces
 '(fringe ((t (:background "#f2f2f2"))))
 '(hl-line ((t (:background "#fffae3"))))
 '(flycheck-error ((t (:foreground "#c00" :underline  "#cc0000"))))
 '(flycheck-warning ((t (:underline "purple"))))
 '(flycheck-fringe-error ((t :foreground "#c00" :background "#efe3e3")))
 '(flycheck-fringe-warning ((t (:foreground "purple" :background "#ece0ec"))))
 )

(custom-set-variables
 '(warning-suppress-types (quote ((undo discard-info))))
 )
