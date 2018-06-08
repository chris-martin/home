{ pkgs, ... }:
{
  virtualisation.virtualbox.host = {
    enable = true;
    enableHardening = false;
    addNetworkInterface = true;
  };
  environment.systemPackages = [ pkgs.virtualbox ];
}
