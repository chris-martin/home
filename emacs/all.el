(eval-when-compile (require 'cl))

(setq custom-file
      (expand-file-name "custom.el"
                        (file-name-directory load-file-name)))

(dolist (name (append '("cursor" "file" "flycheck" "font" "haskell"
                        "markdown" "whitespace" "window")
                      (if (daemonp) nil '("tabbar"))))
  (load-file
   (expand-file-name (concat name ".el")
                     (file-name-directory load-file-name))))

;; Append ~/.bin to the executable path.
(setenv "PATH" (concat "/home/chris/.bin:" (getenv "PATH")))
(setq exec-path (append '("/home/chris/.bin") exec-path))

;; Hide the icon toolbar
(tool-bar-mode -1)

;; Save Emacs command history so it persists across sessions
(savehist-mode 1)

(add-hook 'python-mode-hook 'fci-mode)

;; Projectile - projects - http://batsov.com/projectile/
(add-hook 'after-init-hook 'projectile-global-mode)
(setq projectile-switch-project-action 'projectile-dired)

;; Git commit mode - https://emacs.stackexchange.com/questions/17689
(package-initialize) ; otherwise Emacs doesn't know were to find it
(setq package-initialize-at-startup nil) ; don't do it again
(global-git-commit-mode)

(global-set-key [f8] 'neotree-toggle)
(global-set-key [mouse-8] 'previous-buffer)
(global-set-key [mouse-9] 'next-buffer)

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
(if (not (daemonp))
  (progn
    (setq desktop-save t)
    (desktop-save-mode 1)))

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

(if (not (daemonp))
    (progn
      (require 'centered-window-mode)
      (centered-window-mode)))

(if (not (daemonp)) (global-hl-line-mode))

(setq-default fill-column 80)

;; Don't show a warning when using erase-buffer
(put 'erase-buffer 'disabled nil)

(load custom-file)
