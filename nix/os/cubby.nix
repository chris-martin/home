#
# Cubby is an Intel NUC Kit NUC6i7KYK Mini PC from mid-2017.
#

{ config, pkgs, ... }:

{
  nixpkgs.config = import ../config.nix;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];

  services.postfix.enable = true;

  services.monero = {
    #enable = true;
    #mining.enable = true;
    mining.address = "427YsNgWdfJ9VraWsLC6h4Rygqq1VozD8Q6JC2DoPcHzbRxo6xjtWHyF7B1PBYsqFN8R37itSYthm6xiaDxGoFdFLKnDMn7";
    mining.threads = 1;
  };

  imports = [
    ./hardware.nix
    ./essentials.nix
    ./kitchen-sink.nix
    ./locale.nix
    ./fonts.nix
    ./keyboard.nix
    ./hoogle.nix
    ./avahi.nix
    ./steam.nix
    ./dns.nix
    ./web-browsers.nix
    ./display.nix
    ./cubby-display.nix
    ./ledger.nix
    ./xmonad.nix
    ./cache.nix
    ./nix.nix
    ./direnv.nix
    #./minecraft-server.nix
  ];

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  nix.trustedUsers = [ "@wheel" ];

  nix.maxJobs = 8;
  nix.buildCores = 0;

  time.timeZone = "America/Denver";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  networking.hostName = "cubby";
  networking.networkmanager.enable = true;

  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 8000 ];

  services.redshift.enable = true;
  location.latitude = 47.53;
  location.longitude = -114.1;

  services.localtime.enable = true;

  services.dictd.enable = true;

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  system.stateVersion = "19.09";


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
  #  Audio
  #-----------------------------------------------------------------------------

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  hardware.bluetooth.enable = false;

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';

}
