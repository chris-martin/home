#
# The base for all sys configs.
#

{ config, pkgs, ... }: {

  imports = [ ./hardware.nix ./secret.nix ];

  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

}
