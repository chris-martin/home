{ pkgs, config, ... }:
{
    home-manager.extraSpecialArgs = { pkgsUnstable = import <nixpkgs-unstable> { allowUnfree = true; }; };
    home-manager.users.chris = /home/chris/.config/nix/home/config.nix;
}
