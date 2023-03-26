{ pkgsUnstable, home, ... }:
{
    nixpkgs.config.allowUnfree = true;
    users.defaultUserShell = "/run/current-system/sw/bin/fish";
    system.stateVersion = "19.03";
    services.dictd.enable = true;
    home-manager.extraSpecialArgs = { inherit pkgsUnstable; };
    home-manager.users.chris = home + /config.nix;
}
