#
# Renzo is a Dell XPS 13 non-touch from early 2016.
#

{ config, pkgs, ... }:

let

  pkgsConfig = import ../config.nix;

in {

  system.stateVersion = "17.03";

  nixpkgs.config = pkgsConfig;

  networking.hostName = pkgsConfig.hostName;

  imports = [ ./hardware.nix ./secret.nix ];

  #time.timeZone = "America/Los_Angeles"; # Pacific
  #time.timeZone = "America/Denver"; # Mountain
  #time.timeZone = "America/Chicago"; # Central
  time.timeZone = "America/New_York"; # Eastern

  environment.systemPackages = with pkgs; [
    android-udev-rules curl docker emacs gparted gptfdisk
    htop lsof man_db openssl tree vim wget which
  ];

  fonts = {
    enableFontDir          = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts fira fira-code fira-mono lato inconsolata
      symbola ubuntu_font_family unifont vistafonts
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    consoleFont = "Fira Mono";
    consoleKeyMap = "us";
  };

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  services.redshift = { enable = true; } //
    config.nixpkgs.config.locations.atlanta;

  services.xserver.libinput.enable = false;

  services.xserver.synaptics = {
    enable      = true;
    minSpeed    = "0.8";
    maxSpeed    = "1.4";
    accelFactor = "0.05";
    tapButtons  = false;
    twoFingerScroll = true;
  };

  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql94;
  services.postgresql.authentication = "local all all ident";

  networking = {
    networkmanager.enable = true;
    nameservers = [ "208.67.222.222" "208.67.220.220" ];
    firewall.allowPing = true;
    firewall.allowedTCPPorts = [
      51413 # bittorrent
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.gnome3.enable = true;
    windowManager.xmonad.enable  = false;
    displayManager.gdm.enable    = true;
    autoRepeatDelay    = 250;
    autoRepeatInterval =  50;
  };

  services.unclutter.enable = false;

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

  virtualisation.virtualbox.host = {
    enable              = false;
    enableHardening     = false;
    addNetworkInterface = true;
  };

  virtualisation.docker = {
    enable        = false;
    storageDriver = "devicemapper";
  };

  users.extraUsers.chris = {
    isNormalUser = true;
    description = "Chris Martin";
    extraGroups = [
      "audio" "disk" "docker" "networkmanager" "plugdev"
      "systemd-journal" "wheel" "vboxusers" "video"
    ];
    uid = 1000;
  };

  # https://raw.githubusercontent.com/Yubico/libu2f-host/e2ce7b157b76bb384f8aba7acbfa73af2dd2fee7/70-u2f.rules
  services.udev.extraRules = ''
    ACTION!="add|change", GOTO="u2f_end"

    # Yubico YubiKey
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess"

    LABEL="u2f_end"
  '';

  boot = {
    initrd.luks.devices = [{
      name   = "root";
      device = "/dev/nvme0n1p3";
      preLVM = true;
    }];
    loader = {
      grub.device = "/dev/nvme0n1";
      systemd-boot.enable = false;
    };
    kernelPackages = pkgs.linuxPackages_4_4;
    kernelModules  = ["snd-hda-intel"];
    kernelParams = ["pci=nocrs"];
    cleanTmpDir = true;
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true; # needed for Steam
  };

  hardware.bluetooth.enable = false;

  hardware.opengl.driSupport32Bit = true; # needed for Steam

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  # https://stackoverflow.com/questions/33180784
  nix.extraOptions = "binary-caches-parallel-connections = 5";
}
