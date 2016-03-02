#
# The base config for desktops machines, with GUI stuff.
#

{ config, pkgs, ... }: {

  imports = [ ./sys-base.nix ];

  system.stateVersion = "unstable";

  hardware = {

    pulseaudio.enable = true;

    # Needed for Steam
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  networking = {
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall.allowPing = true;
    #firewall.allowedTCPPorts = [ 8080 ];
  };

  i18n.consoleFont = "Lat2-Terminus16";
  i18n.consoleKeyMap = "us";

  time.timeZone = "America/Los_Angeles";
  #time.timeZone = "America/New_York";

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  environment.systemPackages = with pkgs; [
    android-udev-rules curl docker
    gparted gptfdisk htop lsof man_db
    openssl tree vim wget which
  ];

  services = {

    nixosManual.showManual = true;

    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplipWithPlugin ];
    };

    xserver = {
      enable = true;
      layout = "us";
      desktopManager.gnome3.enable = true;
      displayManager.gdm.enable    = true;
    };

    redshift = {
      enable = true;

      # San Mateo
      latitude  = "37.56";
      longitude = "-122.33";
    };

    unclutter.enable = true;
  };

  nixpkgs.config.systemd.user.services.emacs = {

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
      ExecStart = "${pkgs.bash}/bin/bash -c 'source ${config.system.build.setEnvironment} emacs --daemon --no-desktop'";
      ExecStop  = "${pkgs.emacs}/bin/emacsclient --eval '(kill-emacs)'";
      Restart   = "always";
    };

    wantedBy = [ "default.target" ];
  };

  nixpkgs.config.systemd.services.emacs.enable = true;

  virtualisation = {

    virtualbox.host = {
      enable              = true;
      enableHardening     = false;
      addNetworkInterface = true;
    };

    docker = {
      enable           = true;
      storageDriver    = "devicemapper";
      socketActivation = false;
    };
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
