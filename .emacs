(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'tmux-xterm-keys)

(global-set-key [f8] 'neotree-toggle)

; git modes
; https://github.com/magit/git-modes/
(add-to-list 'load-path "~/.emacs.d/lisp/git-modes/")
(require 'gitattributes-mode)
(require 'git-commit-mode)
(require 'gitconfig-mode)
(require 'gitignore-mode)
(require 'git-rebase-mode)

; disable spell checking in git commit mode
; https://github.com/magit/git-modes/issues/106
(eval-after-load "git-commit-mode"
  '(cond
    ((boundp 'git-commit-mode-hook) ; old
     (remove-hook 'git-commit-mode-hook 'flyspell-mode))
    ((boundp 'git-commit-setup-hook) ; new
     (remove-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell))))

; http://www.emacswiki.org/emacs-en/CopyAndPaste
; http://www.emacswiki.org/emacs-en/xclip.el
(defun paste ()
  "Yank from the X clipboard using xclip."
    (interactive)
    (and mark-active (filter-buffer-substring (region-beginning) (region-end) t))
    (insert (shell-command-to-string "xclip -o -selection clipboard")))

; Show line numbers
(global-linum-mode 1)

; Format line numbers right-aligned with padding
(setq linum-format (lambda (line)
  (propertize (format
    (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
      (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))


; Make backup files even in version-controlled directories
(setq vc-make-backup-files t)

; Set directory for backup files
; http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(make-directory backup-dir t)
(setq backup-directory-alist `(("" . ,backup-dir)))

; https://stackoverflow.com/questions/2020941/how-can-i-hide-the-backup-files-that-emacs-creates
; Set directory for autosave files
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(make-directory autosave-dir t)
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

; Follow symlinks without prompting
; https://stackoverflow.com/questions/15390178/emacs-and-symbolic-links
(setq vc-follow-symlinks 1)

; Remove trailing whitespace from saved files
; https://github.com/lewang/ws-butler
(require 'ws-butler)
(add-hook 'text-mode-hook 'ws-butler-mode)
(add-hook 'prog-mode-hook 'ws-butler-mode)

; Enable mouse integration
; https://bitheap.org/mouseterm/
(unless window-system
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1))))

; Fix shift+up
; https://groups.google.com/forum/?fromgroups=#!topic/gnu.emacs.help/rR478H4BDU8
(define-key input-decode-map "\e[1;2A" [S-up])
(if (equal "xterm" (tty-type))
  (define-key input-decode-map "\e[1;2A" [S-up]))

; Markdown
; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

; https://stackoverflow.com/questions/384284/how-do-i-rename-an-open-file-in-emacs
; http://steve.yegge.googlepages.com/my-dot-emacs-file
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

; https://sites.google.com/site/steveyegge2/my-dot-emacs-file
(defun move-buffer-file (dir)
 "Moves both current buffer and file it's visiting to DIR."
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

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'after-init-hook #'projectile-global-mode)

(defun kill-emacs-and-restart ()
  (interactive)
  (kill-emacs 123))
