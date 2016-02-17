# My NixOS fork: https://github.com/chris-martin/nixpkgs

{ config, pkgs, ... }:

{
  imports = [
    # The results of the hardware scan
    ./hardware-configuration.nix

    # Anything else not version-controlled
    ./secret.nix
  ];

  system.stateVersion = "unstable";

  hardware = {

    pulseaudio.enable = true;

    # Needed for Steam
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  boot = {
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/sda3";
        preLVM = true;
      }
    ];
    loader = {
      grub.device = "/dev/sda";
      gummiboot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "annemarie";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall.allowPing = true;
    #firewall.allowedTCPPorts = [ 8080 ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  #time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    android-udev-rules
    curl
    docker
    emacs
    fish
    gitAndTools.gitFull
    gparted
    gptfdisk
    htop
    jq
    lsof
    man_db
    nix-repl
    openssl
    psmisc
    tmux
    tree
    unzip
    vim
    wget
    which
    xclip
    xorg.xkill
    zip
  ];

  services = {

    nixosManual.showManual = true;

    # Printing
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint pkgs.hplipWithPlugin ];
    };

    # The X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";

      desktopManager.gnome3.enable = true;
      #desktopManager.default = "gnome3";
      displayManager.gdm.enable = true;

      # Touchpad
      synaptics = {
        enable = true;
        tapButtons = false;
        twoFingerScroll = true;
        minSpeed = "0.75";
        maxSpeed = "5.5";
        accelFactor = "0.015";
        palmDetect = true;
        palmMinWidth = 3;
        scrollDelta = 65;

        # Left edge is adjusted because palm detection isn't good
        # enough on the edges. This touchpad is off-center and my
        # left palm tends to graze it.
        additionalOptions = ''
          Option "AreaLeftEdge" "450"
        '';
      };
    };

    redshift = {
      enable = true;

      # San Mateo
      latitude = "37.56";
      longitude = "-122.33";
    };

    unclutter.enable = true;
  };

  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    environment = {
      GTK_DATA_PREFIX = config.system.path;
      SSH_AUTH_SOCK = "%t/ssh-agent";
      GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
    };
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.bash}/bin/bash -c 'source ${config.system.build.setEnvironment}; emacs --daemon'";
      ExecStop = "${pkgs.emacs}/bin/emacsclient --eval '(kill-emacs)'";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.emacs.enable = true;

  virtualisation = {

    # VirtualBox
    virtualbox.host = {
      enable = true;
      enableHardening = false;
      addNetworkInterface = true;
    };

    # Docker
    docker = {
      enable = true;
      storageDriver = "devicemapper";
      socketActivation = false;
    };
  };

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      symbola
      ubuntu_font_family
      unifont
      vistafonts
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.chris = {
    name = "chris";
    group = "users";
    extraGroups = [
      "audio" "disk" "docker" "networkmanager" "plugdev"
      "systemd-journal" "wheel" "vboxusers" "video"
    ];
    createHome = true;
    uid = 1000;
    home = "/home/chris";
    shell = "/run/current-system/sw/bin/bash";
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
  nix.extraOptions = ''
    binary-caches-parallel-connections = 25
  '';

}
