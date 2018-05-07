#
# Cubby is an Intel NUC Kit NUC6i7KYK Mini PC from mid-2017.
#

{ config, pkgs, ... }:

{
  nixpkgs.config = import ../config.nix;

  imports = [
    ./hardware.nix
    ./secret.nix
    ./essentials.nix
    ./kitchen-sink.nix
    ./locale.nix
    ./fonts.nix
    ./keyboard.nix
    ./hoogle.nix
    ./avahi.nix
    ./steam.nix
    ./dns.nix
  ];

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  nix.trustedUsers = [ "@wheel" ];

  time.timeZone = "America/New_York"; # Eastern


  #-----------------------------------------------------------------------------
  #  SSH
  #-----------------------------------------------------------------------------

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };


  #-----------------------------------------------------------------------------
  #  Networking
  #-----------------------------------------------------------------------------

  networking.hostName = "cubby";
  networking.networkmanager.enable = true;


  #-----------------------------------------------------------------------------
  #  Graphical environment
  #-----------------------------------------------------------------------------

  services.xserver.enable = true;

  services.xserver.desktopManager.gnome3.enable = true;

  #services.xserver.desktopManager.default = "none";

  #services.xserver.desktopManager.xterm.enable = false;

  #services.xserver.windowManager.default = "xmonad";

  services.xserver.windowManager.xmonad = {
    #enable = true;
    extraPackages = haskellPackages: with haskellPackages; [
      xmonad-contrib xmonad-extras
    ];
  };


  #-----------------------------------------------------------------------------
  #  Firewall
  #-----------------------------------------------------------------------------

  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [
    51413 # bittorrent
  ];


  #-----------------------------------------------------------------------------
  #  Location-based services
  #-----------------------------------------------------------------------------

  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";

  services.localtime.enable = true;


  #-----------------------------------------------------------------------------
  #  Hydra
  #-----------------------------------------------------------------------------

  services.hydra.enable = false;
  services.hydra.hydraURL = "http://localhost:30329";
  services.hydra.port = 30329;
  services.hydra.notificationSender = "ch.martin@gmail.com";


  #-----------------------------------------------------------------------------
  #  VirtualBox
  #-----------------------------------------------------------------------------

  virtualisation.virtualbox.host.enable = false;
  virtualisation.virtualbox.host.enableHardening = false;
  virtualisation.virtualbox.host.addNetworkInterface = true;


  #-----------------------------------------------------------------------------
  #  Docker
  #-----------------------------------------------------------------------------

  virtualisation.docker.enable = false;
  virtualisation.docker.storageDriver = "devicemapper";


  #-----------------------------------------------------------------------------
  #  Users
  #-----------------------------------------------------------------------------

  users.users = {
    chris = {
      isNormalUser = true;
      description = "Chris Martin";
      extraGroups = ["wheel"];
      uid = 1000;
      openssh.authorizedKeys.keys = import ./keys.nix;
    };
    julie = {
      isNormalUser = true;
      description = "Julie Moronuki";
      uid = 1001;
    };
  };


  #-----------------------------------------------------------------------------
  #  Boot
  #-----------------------------------------------------------------------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelParams = [ "nomodeset" ];
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.cleanTmpDir = true;


  #-----------------------------------------------------------------------------
  #  Mounting
  #-----------------------------------------------------------------------------

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';


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


  #-----------------------------------------------------------------------------
  #  NixOS
  #-----------------------------------------------------------------------------

  system.stateVersion = "18.03";

  # https://stackoverflow.com/questions/33180784
  nix.extraOptions = "binary-caches-parallel-connections = 5";

}
