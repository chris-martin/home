{ config, pkgs, ... }:

{
    nixpkgs.config = import /home/chris/.config/nixpkgs/config.nix;

    imports = [
      ./audio.nix
      ./boot.nix
      ./display.nix
      ./hardware.nix
      ./networking.nix
      ./nix.nix
      ./users.nix

      <local-nixos-modules/avahi.nix>
      <local-nixos-modules/cache.nix>
      <local-nixos-modules/display.nix>
      <local-nixos-modules/dns.nix>
      <local-nixos-modules/essentials.nix>
      <local-nixos-modules/fonts.nix>
      <local-nixos-modules/keyboard.nix>
      <local-nixos-modules/nix.nix>
      <local-nixos-modules/printing.nix>
      <local-nixos-modules/ssh.nix>
      <local-nixos-modules/web-browsers.nix>

      <home-manager/nixos>
    ];

    users.defaultUserShell = "/run/current-system/sw/bin/fish";
    time.timeZone = "America/Denver";
    location.provider = "geoclue2";
    services.dictd.enable = true;
    environment.etc."fuse.conf".text = ''
        user_allow_other
    '';
    system.stateVersion = "19.09";
}