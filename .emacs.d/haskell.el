(add-hook 'haskell-mode-hook 'intero-mode)

(setq haskell-process-wrapper-function
  (lambda (args) (apply 'nix-shell-command (nix-current-sandbox) args)))
