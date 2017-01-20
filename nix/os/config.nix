{ config, pkgs, ... }:

let

pkgsConfig = import ../config.nix;

box = builtins.getAttr pkgsConfig.hostName {
  annemarie = boxes/annemarie.nix;
  renzo     = boxes/renzo.nix;
};

boxType = builtins.getAttr pkgsConfig.hostName {
  annemarie = boxTypes/desktop.nix;
  renzo     = boxTypes/desktop.nix;
};

in

{

  nixpkgs.config = pkgsConfig;

  networking.hostName = pkgsConfig.hostName;

  imports = [ ./hardware.nix ./secret.nix box boxType ];

  i18n.defaultLocale = "en_US.UTF-8";

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

}
