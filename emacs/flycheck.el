;; Use flycheck everywhere
(add-hook 'after-init-hook 'global-flycheck-mode)

;; Disable elisp flycheck - don't know why, but it always generates errors.
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc)))

;; If there is a Nix shell configuration present, have flycheck use it to
;; execute commands. For example, flycheck-haskell needs GHC, which I don't
;; install globally so that projects can use different GHC versions.
(setq flycheck-command-wrapper-function
        (lambda (command) (apply 'nix-shell-command (nix-current-sandbox) command))
      flycheck-executable-find
        (lambda (cmd) (nix-executable-find (nix-current-sandbox) cmd)))
