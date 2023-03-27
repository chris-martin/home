{ config, pkgs, ... }:

{
  networking = {
    hostName = "cubby";
    networkmanager.enable = true;
    firewall.allowPing = true;
    firewall.allowedTCPPorts = [ ];
  };
}
