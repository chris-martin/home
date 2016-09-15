(setenv "NIX_PATH" (shell-command-to-string ". ~/.bashrc; echo -n $NIX_PATH"))
