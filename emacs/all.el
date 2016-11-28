(eval-when-compile (require 'cl))

(setq custom-file
      (expand-file-name "custom.el"
                        (file-name-directory load-file-name)))

(dolist (name (append '("autosave" "backup" "cursor" "exec-path" "nix-path"
                        "file" "flycheck" "font" "git" "haskell" "line-numbers"
                        "line-wrapping"
                        "markdown" "mouse" "org" "whitespace" "window")
                      (if (daemonp) nil '("tabbar"))))
  (load-file
   (expand-file-name (concat name ".el")
                     (file-name-directory load-file-name))))

;; Don't show the startup buffer
(setq inhibit-startup-message t)

;; Hide the icon toolbar
(tool-bar-mode -1)

;; Save Emacs command history so it persists across sessions
(savehist-mode 1)

(add-hook 'python-mode-hook 'fci-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq
 web-mode-markup-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-css-indent-offset 2)

;; Projectile - projects - http://batsov.com/projectile/
(add-hook 'after-init-hook 'projectile-global-mode)
(setq projectile-switch-project-action 'projectile-dired)

(global-set-key [f8] 'neotree-toggle)

;; cua provides ctrl+x,c,v bindings for cut,copy,paste.
(if (not (daemonp)) (cua-mode t))

;; Follow symlinks without prompting
;; https://stackoverflow.com/questions/15390178
(setq vc-follow-symlinks 1)

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
