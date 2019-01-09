#
# Renzo is a Dell XPS 13 non-touch from early 2016.
#

{ config, pkgs, ... }:

{
  nixpkgs.config = import ../config.nix;

  imports = [
    ./hardware.nix
    ./essentials.nix
    ./kitchen-sink.nix
    ./locale.nix
    ./fonts.nix
    ./keyboard.nix
    ./hoogle.nix
    ./avahi.nix
    ./touchpad.nix
    ./steam.nix
    ./dns.nix
    ./web-browsers.nix
    ./display.nix
    ./renzo-display.nix
    ./xmonad.nix
    ./ledger.nix
    ./cache.nix
    ./nix.nix
  ];

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  nix.trustedUsers = [ "@wheel" ];

  time.timeZone = "America/Denver";

  networking.hostName = "renzo";
  networking.networkmanager.enable = true;

  networking.firewall.allowPing = true;

  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";

  services.localtime.enable = true;

  environment.etc."fuse.conf".text = "user_allow_other";

  system.stateVersion = "18.09";


  #-----------------------------------------------------------------------------
  #  Users
  #-----------------------------------------------------------------------------

  users.extraUsers.chris = {
    isNormalUser = true;
    description = "Chris Martin";
    extraGroups = [
      "audio" "disk" "docker" "networkmanager" "plugdev"
      "systemd-journal" "wheel" "vboxusers" "video"
    ];
    uid = 1000;
  };


  #-----------------------------------------------------------------------------
  #  Boot
  #-----------------------------------------------------------------------------

  boot.initrd.luks.devices = [{
    name   = "root";
    device = "/dev/nvme0n1p3";
    preLVM = true;
  }];

  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.systemd-boot.enable = false;

  boot.cleanTmpDir = true;


  #-----------------------------------------------------------------------------
  #  Kernel
  #-----------------------------------------------------------------------------

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules  = ["snd-hda-intel"];
  boot.kernelParams = ["pci=nocrs"];


  #-----------------------------------------------------------------------------
  #  Audio
  #-----------------------------------------------------------------------------

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  hardware.bluetooth.enable = false;

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';

  # https://github.com/NixOS/nixpkgs/issues/24184
  services.xserver.displayManager.sessionCommands = ''
    amixer -c 0 cset 'numid=10' 1
  '';

}
