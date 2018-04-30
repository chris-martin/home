#
# Renzo is a Dell XPS 13 non-touch from early 2016.
#

{ config, pkgs, ... }:

{
  nixpkgs.config = import ../config.nix;

  imports = [ ./hardware.nix ./secret.nix ];

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  nix.trustedUsers = [ "@wheel" ];

  time.timeZone = "America/New_York"; # Eastern


  #-----------------------------------------------------------------------------
  #  Networking
  #-----------------------------------------------------------------------------

  networking.hostName = "renzo";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "208.67.222.222" "208.67.220.220" ];


  #-----------------------------------------------------------------------------
  #  Software
  #-----------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    alsaUtils android-udev-rules curl fish gparted gptfdisk
    htop lsof man_db openssl tmux tree vim wget which
  ];


  #-----------------------------------------------------------------------------
  #  Locale
  #-----------------------------------------------------------------------------

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.consoleKeyMap = "us";
  services.xserver.layout = "us";


  #-----------------------------------------------------------------------------
  #  Graphical environment
  #-----------------------------------------------------------------------------

  services.xserver.enable = true;

  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.default = "none";
  #services.xserver.displayManager.slim.enable = true;
  #services.xserver.windowManager.xmonad.enable = true;
  #services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  #services.xserver.windowManager.default = "xmonad";


  #-----------------------------------------------------------------------------
  #  Firewall
  #-----------------------------------------------------------------------------

  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [
    51413 # bittorrent
  ];


  #-----------------------------------------------------------------------------
  #  Fonts
  #-----------------------------------------------------------------------------

  fonts.enableFontDir = true;
  fonts.enableGhostscriptFonts = true;

  fonts.fonts = with pkgs; [
    corefonts fira fira-code fira-mono lato google-fonts inconsolata
    rollandin-emilie symbola ubuntu_font_family unifont vistafonts
  ];

  i18n.consoleFont = "Fira Mono";


  #-----------------------------------------------------------------------------
  #  Location-based services
  #-----------------------------------------------------------------------------

  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";

  services.localtime.enable = true;


  #-----------------------------------------------------------------------------
  #  DNS service discovery
  #-----------------------------------------------------------------------------

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;


  #-----------------------------------------------------------------------------
  #  Mouse
  #-----------------------------------------------------------------------------

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.minSpeed = "0.8";
  services.xserver.synaptics.maxSpeed = "1.4";
  services.xserver.synaptics.accelFactor = "0.05";
  services.xserver.synaptics.tapButtons = false;
  services.xserver.synaptics.twoFingerScroll = true;

  services.xserver.libinput.enable = false;


  #-----------------------------------------------------------------------------
  #  Keyboard
  #-----------------------------------------------------------------------------

  services.xserver.autoRepeatDelay = 250;
  services.xserver.autoRepeatInterval = 50;


  #-----------------------------------------------------------------------------
  #  Hoogle
  #-----------------------------------------------------------------------------

  services.hoogle.enable = true;
  services.hoogle.port = 13723;
  services.hoogle.haskellPackages = (import <unstable> { }).haskellPackages;
  services.hoogle.packages = (import ./hoogle.nix).packages;


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
  #  YubiKey
  #-----------------------------------------------------------------------------

  services.udev.packages = [ pkgs.libu2f-host ];


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
  #  Mounting
  #-----------------------------------------------------------------------------

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';


  #-----------------------------------------------------------------------------
  #  Video
  #-----------------------------------------------------------------------------

  hardware.opengl.driSupport32Bit = true; # needed for Steam


  #-----------------------------------------------------------------------------
  #  Audio
  #-----------------------------------------------------------------------------

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # needed for Steam
  hardware.pulseaudio.support32Bit = true;

  hardware.bluetooth.enable = false;

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';

  # https://github.com/NixOS/nixpkgs/issues/24184
  services.xserver.displayManager.sessionCommands = ''
    amixer -c 0 cset 'numid=10' 1
  '';


  #-----------------------------------------------------------------------------
  #  Postgres
  #-----------------------------------------------------------------------------

  services.postgresql.enable = false;
  services.postgresql.package = pkgs.postgresql94;
  services.postgresql.authentication = "local all all ident";


  #-----------------------------------------------------------------------------
  #  NixOS
  #-----------------------------------------------------------------------------

  system.stateVersion = "18.03";

  # https://stackoverflow.com/questions/33180784
  nix.extraOptions = "binary-caches-parallel-connections = 5";

  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

}
