;; https://stackoverflow.com/questions/2020941
;; Set directory for autosave files
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(make-directory autosave-dir t)
(setq auto-save-list-file-prefix autosave-dir
      auto-save-file-name-transforms `((".*" ,autosave-dir t)))
