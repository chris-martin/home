;;; .emacs --- emacs config

;;; Commentary:

;;; Code:

(eval-when-compile (require 'cl))

;; Append ~/.bin to the executable path.
(setenv "PATH" (concat "/home/chris/.bin:" (getenv "PATH")))
(setq exec-path (append '("/home/chris/.bin") exec-path))

;; Hide the icon toolbar
(tool-bar-mode -1)

;; Save Emacs command history so it persists across sessions
(savehist-mode 1)

;; Set cursor to a thin vertical bar
(setq-default cursor-type 'bar)

(setq-default indent-tabs-mode nil)      ; Fuck tabs

(add-hook 'after-init-hook 'global-flycheck-mode)
(add-hook 'after-init-hook 'projectile-global-mode)

;; Git commit mode - https://emacs.stackexchange.com/questions/17689
(package-initialize)                     ; otherwise Emacs doesn't know were to find it
(setq package-initialize-at-startup nil) ; don't do it again
(global-git-commit-mode)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(global-set-key [f8] 'neotree-toggle)

(cua-mode t)            ; ctrl+x,c,v bindings for cut,copy,paste

(global-linum-mode 1)   ; Show line numbers

;; Format t line numbers right-aligned with padding
(setq
 linum-format
 (lambda (line)
   (propertize
    (format
     (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
       (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

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
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

;; Follow symlinks without prompting
;; https://stackoverflow.com/questions/15390178
(setq vc-follow-symlinks 1)

;; Ws-butler removes trailing whitespace from saved files.
;; Ws-butler causes Emacs --daemon to hang, so in daemon mode we set it
;; up only when creating frames, so it won't happen on daemon startup.
;; https://github.com/lewang/ws-butler/issues/4
(defun ws-butler-add-hooks ()
  "Add ws-butler hooks."
  (add-hook 'text-mode-hook 'ws-butler-mode)
  (add-hook 'prog-mode-hook 'ws-butler-mode))
(if (daemonp)
    (add-hook 'before-make-frame-hook 'ws-butler-add-hooks)
  (ws-butler-add-hooks))

;; Enable mouse integration - https://bitheap.org/mouseterm/
(unless window-system
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 1))))

;; Markdown - http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; https://stackoverflow.com/questions/384284/how-do-i-rename-an-open-file-in-emacs
;; http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "FNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;; https://sites.google.com/site/steveyegge2/my-dot-emacs-file
(defun move-buffer-file (dir)
  "Move both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn (copy-file filename newname 1)
             (delete-file filename)
             (set-visited-file-name newname)
             (set-buffer-modified-p nil)      t))))

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(provide '.emacs)
;;; .emacs ends here
