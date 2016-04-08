builtins.getAttr (builtins.getEnv "HOSTNAME") {
  annemarie = import ./user-desktop.nix;
  renzo     = import ./user-desktop.nix;
  mandeeza  = import ./user-server.nix;
}
