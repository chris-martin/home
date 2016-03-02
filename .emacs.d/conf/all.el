;;; all.el --- emacs config

;;; Commentary:

;;; Code:

(eval-when-compile (require 'cl))

(load-file "/home/chris/.emacs.d/conf/cursor.el")
(load-file "/home/chris/.emacs.d/conf/file.el")
(load-file "/home/chris/.emacs.d/conf/tabbar.el")
(load-file "/home/chris/.emacs.d/conf/markdown.el")
(load-file "/home/chris/.emacs.d/conf/whitespace.el")

;; Append ~/.bin to the executable path.
(setenv "PATH" (concat "/home/chris/.bin:" (getenv "PATH")))
(setq exec-path (append '("/home/chris/.bin") exec-path))

;; Hide the icon toolbar
(tool-bar-mode -1)

;; Save Emacs command history so it persists across sessions
(savehist-mode 1)

;; Set the default font
(if (not (daemonp))
    (let* ((font-size (if (string= system-name "renzo") "14" "10"))
           (f (concat "DejaVu Sans Mono Book " font-size)))
    (add-to-list 'default-frame-alist `(font . ,f))
    (set-face-attribute 'default t :font f)))

(add-hook 'after-init-hook 'global-flycheck-mode)

;; Projectile - projects - http://batsov.com/projectile/
(add-hook 'after-init-hook 'projectile-global-mode)
(setq projectile-switch-project-action 'projectile-dired)

;; Git commit mode - https://emacs.stackexchange.com/questions/17689
(package-initialize) ; otherwise Emacs doesn't know were to find it
(setq package-initialize-at-startup nil) ; don't do it again
(global-git-commit-mode)

(global-set-key [f8] 'neotree-toggle)

;; cua provides ctrl+x,c,v bindings for cut,copy,paste.
(if (not (daemonp)) (cua-mode t))

(global-linum-mode 1) ; Show line numbers

;; Format t line numbers right-aligned with padding
(setq
 linum-format
 (lambda (line)
   (propertize
    (format
     (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
       (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;; Automatically save the desktop (open tabs, etc)
(setq desktop-save t)
(desktop-save-mode 1)

;; Make backup files even in version-controlled directories
(setq vc-make-backup-files t)

;; Set directory for backup files
;; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(make-directory backup-dir t)
(setq backup-directory-alist `(("" . ,backup-dir)))

;; https://stackoverflow.com/questions/2020941
;; Set directory for autosave files
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(make-directory autosave-dir t)
(setq auto-save-list-file-prefix autosave-dir
      auto-save-file-name-transforms `((".*" ,autosave-dir t)))

;; Follow symlinks without prompting
;; https://stackoverflow.com/questions/15390178
(setq vc-follow-symlinks 1)

;; Enable mouse integration - https://bitheap.org/mouseterm/
(unless window-system
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 1))))

(global-set-key (kbd "C-/") 'comment-dwim)

(helm-mode 1)
(helm-projectile-on)

(provide '.emacs)
;;; all.el ends here
