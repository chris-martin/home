builtins.getAttr (builtins.getEnv "HOSTNAME") {
  annemarie = import ./sys-annemarie.nix;
  renzo     = import ./sys-renzo.nix;
  mandeeza  = import ./sys-mandeeza.nix;
}
