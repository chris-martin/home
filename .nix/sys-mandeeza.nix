{ config, pkgs, ... }: {

  imports = [ ./sys-base.nix ./nixos-in-place.nix ];

  networking.hostName = "mandeeza";

}
