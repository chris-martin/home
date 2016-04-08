#
# The base for servers.
#

{ config, pkgs, ... }: {

  imports = [ ./sys-base.nix ];

  system.stateVersion = "15.09";

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  time.timeZone = "America/Los_Angeles";

  environment.systemPackages = with pkgs; [
    curl fish gitAndTools.gitFull htop lsof
    nginx tmux tree vim wget which
  ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  users.extraUsers.chris = {
    isNormalUser = true;
    description = "Chris Martin";
    uid = 1000;
    extraGroups = ["systemd-journal" "wheel"];
  };

}
