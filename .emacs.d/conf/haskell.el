(setq haskell-process-wrapper-function
  (lambda (args) (apply 'nix-shell-command (nix-current-sandbox) args)))

(setq haskell-stylish-on-save t)
