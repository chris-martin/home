#
# NixOS config for desktops machines, with GUI stuff.
#

{ config, pkgs, ... }: {

  system.stateVersion = "16.03";

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true; # needed for Steam
  };

  hardware.bluetooth.enable = true;

  hardware.opengl.driSupport32Bit = true; # needed for Steam

  networking = {
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall.allowPing = true;
    firewall.allowedTCPPorts = [
      51413 # bittorrent
    ];
  };

  i18n.consoleFont = "Lat2-Terminus16";
  i18n.consoleKeyMap = "us";

  #time.timeZone = "America/Los_Angeles";
  time.timeZone = "America/New_York";

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  environment.systemPackages = with pkgs; [
    android-udev-rules curl docker emacs
    gparted gptfdisk htop lsof man_db
    openssl tree vim wget which nodePackages.peerflix
  ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    publish.addresses = true;
  };

  services.nixosManual.showManual = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint hplipWithPlugin ];
  };

  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.gnome3.enable = true;
    displayManager.gdm.enable    = true;
  };

  services.redshift = {
    enable = true;

    # Lexington
    latitude  = "38.062373";
    longitude = "-84.50178";

    # San Mateo
    #latitude  = "37.56";
    #longitude = "-122.33";
  };

  services.unclutter.enable = true;

  services.peerflix.enable = true;

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
    enable           = true;
    storageDriver    = "devicemapper";
    socketActivation = false;
  };

  fonts = {
    enableFontDir          = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts inconsolata symbola ubuntu_font_family
      unifont vistafonts
    ];
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

  system.activationScripts.dockerGc = ''
    echo ".*-data(_[0-9]+)?" > /etc/docker-gc-exclude-containers
    echo -e "alpine:.*\ncardforcoin/bitgo-express:.*\nclojure:.*\nmemcached:.*\nnginx:.*\npostgres:.*\npython:.*\nredis:.*\nspotify/docker-gc:.*\ntianon/true\nubuntu:.*" > /etc/docker-gc-exclude
  '';

  # Yubikey
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess"
  '';

  # https://stackoverflow.com/questions/33180784
  nix.extraOptions = "binary-caches-parallel-connections = 5";

}
