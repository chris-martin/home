{ pkgsUnstable, home, localFlakes, ... }: {
  nixpkgs.config.allowUnfree = true;
  users.defaultUserShell = "/run/current-system/sw/bin/fish";
  system.stateVersion = "19.03";
  services.dictd.enable = true;
  home-manager.extraSpecialArgs = { inherit pkgsUnstable localFlakes; };
  home-manager.users.chris = home + /config.nix;
}
