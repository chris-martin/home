#
# Cubby is an Intel NUC Kit NUC6i7KYK Mini PC from mid-2017.
#

{ config, pkgs, ... }:

let

  pkgsConfig = import ../config.nix;

in {

  nixpkgs.config = pkgsConfig;

  imports = [ ./hardware.nix ./secret.nix ];

  users.defaultUserShell = "/run/current-system/sw/bin/bash";


  #-----------------------------------------------------------------------------
  #  Networking
  #-----------------------------------------------------------------------------

  networking.hostName = "cubby";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "208.67.222.222" "208.67.220.220" ];


  #-----------------------------------------------------------------------------
  #  Software
  #-----------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    android-udev-rules curl docker emacs gparted gptfdisk
    htop lsof man_db openssl tree vim wget which
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
  #  Fonts
  #-----------------------------------------------------------------------------

  fonts.enableFontDir = true;
  fonts.enableGhostscriptFonts = true;

  fonts.fonts = with pkgs; [
    corefonts fira fira-code fira-mono lato inconsolata
    symbola ubuntu_font_family unifont vistafonts
  ];


  #-----------------------------------------------------------------------------
  #  Location
  #-----------------------------------------------------------------------------

  services.redshift = { enable = true; } //
    #{ latitude = "33.784190"; longitude = "-84.374263"; } # atlanta
    { latitude = "38.062373"; longitude = "-84.50178"; } # lexington
    #{ latitude = "37.56"; longitude = "-122.33"; } # san mateo
    ;

  time.timeZone = "America/New_York"; # Eastern
  #time.timeZone = "America/Chicago"; # Central
  #time.timeZone = "America/Denver"; # Mountain
  #time.timeZone = "America/Los_Angeles"; # Pacific


  #-----------------------------------------------------------------------------
  #  DNS service discovery
  #-----------------------------------------------------------------------------

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;


  #-----------------------------------------------------------------------------
  #  Keyboard
  #-----------------------------------------------------------------------------

  services.xserver.autoRepeatDelay = 250;
  services.xserver.autoRepeatInterval = 50;


  #-----------------------------------------------------------------------------
  #  Emacs
  #-----------------------------------------------------------------------------

  systemd.user.services.emacs = {

    description = "Emacs Daemon";

    environment = {
      GTK_DATA_PREFIX = config.system.path;
      SSH_AUTH_SOCK   = "%t/ssh-agent";
      GTK_PATH        = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      NIX_PROFILES    = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
      TERMINFO_DIRS   = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF     = "dict-dir /run/current-system/sw/lib/aspell";
    };

    serviceConfig = {
      Type      = "forking";
      ExecStart = "${pkgs.bash}/bin/bash -c 'source ${config.system.build.setEnvironment}; emacs --daemon --no-desktop'";
      ExecStop  = "${pkgs.emacs}/bin/emacsclient --eval '(kill-emacs)'";
      Restart   = "always";
    };

    wantedBy = [ "default.target" ];
  };

  systemd.services.emacs.enable = true;


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

  # https://raw.githubusercontent.com/Yubico/libu2f-host/e2ce7b157b76bb384f8aba7acbfa73af2dd2fee7/70-u2f.rules
  services.udev.extraRules = ''
    ACTION!="add|change", GOTO="u2f_end"

    # Yubico YubiKey
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess"

    LABEL="u2f_end"
  '';


  #-----------------------------------------------------------------------------
  #  Boot
  #-----------------------------------------------------------------------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelParams = [ "nomodeset" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.cleanTmpDir = true;


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


  #-----------------------------------------------------------------------------
  #  Postgres
  #-----------------------------------------------------------------------------

  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql94;
  services.postgresql.authentication = "local all all ident";


  #-----------------------------------------------------------------------------
  #  NixOS
  #-----------------------------------------------------------------------------

  system.stateVersion = "17.03";

  # https://stackoverflow.com/questions/33180784
  nix.extraOptions = "binary-caches-parallel-connections = 5";

}
