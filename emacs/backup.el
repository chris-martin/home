;; Make backup files even in version-controlled directories
(setq vc-make-backup-files t)

;; Set directory for backup files
;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(make-directory backup-dir t)
(setq backup-directory-alist `(("" . ,backup-dir)))
