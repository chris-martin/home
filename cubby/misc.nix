{ home, pkgsUnstable, localFlakes, ... }: {
  nixpkgs.config.allowUnfree = true;
  users.defaultUserShell = "/run/current-system/sw/bin/fish";
  services.dictd.enable = true;
  system.stateVersion = "19.09";
  home-manager.extraSpecialArgs = { inherit pkgsUnstable localFlakes; };
  home-manager.users.chris = home + /config.nix;
}
