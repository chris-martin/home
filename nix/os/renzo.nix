#
# Renzo is a Dell XPS 13 non-touch from early 2016.
#

{ config, pkgs, ... }:

{
  nixpkgs.config = import ../config.nix;

  imports = [
    ./hardware.nix
    ./essentials.nix
    # ./kitchen-sink.nix
    ./fonts.nix
    ./keyboard.nix
    # ./hoogle.nix
    ./avahi.nix
    ./touchpad.nix
    ./dns.nix
    # ./web-browsers.nix
    ./display.nix
    ./renzo-display.nix
    ./cache.nix
    ./nix.nix
    <home-manager/nixos>
  ];

  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
  };

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  users.defaultUserShell = "/run/current-system/sw/bin/fish";

  nix.settings.trusted-users = [ "@wheel" ];

  time.timeZone = "America/Denver";

  networking.hostName = "renzo";
  networking.networkmanager.enable = true;

  networking.firewall.allowPing = true;

  location.provider = "geoclue2";

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  system.stateVersion = "19.03";

  services.dictd.enable = true;


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
  home-manager.users.chris = import ../home.nix;


  #-----------------------------------------------------------------------------
  #  Boot
  #-----------------------------------------------------------------------------

  boot.initrd.luks.devices.root = {
    device = "/dev/nvme0n1p3";
    preLVM = true;
  };

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
  services.acpid.enable = true;
  services.acpid.handlers.fixHeadphoneNoise = {
    event = "jack/headphone HEADPHONE plug";
    action = "${pkgs.alsaUtils}/bin/amixer -c0 sset 'Headphone Mic Boost' 10dB";
  };

}
