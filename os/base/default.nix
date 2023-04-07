{ pkgs, ... }: {

  imports = [
    ./modules/authorized-keys.nix
    ./modules/cache.nix
    ./modules/display.nix
    ./modules/essentials.nix
    ./modules/hoogle
    ./modules/nix.nix
  ];

  console.font = "Fira Mono";

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = [ pkgs.corefonts pkgs.fira-mono ];
  };

  location.provider = "geoclue2";

  networking.firewall.allowPing = true;

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  services.dictd.enable = true;

  services.hoogle.enable = true;

  services.monero.mining = {
    address =
      "427YsNgWdfJ9VraWsLC6h4Rygqq1VozD8Q6JC2DoPcHzbRxo6xjtWHyF7B1PBYsqFN8R37itSYthm6xiaDxGoFdFLKnDMn7";
    threads = 1;
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
  };

  services.xserver = {
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
    libinput.touchpad = {
      accelSpeed = "0.01";
      tapping = false;
      scrollMethod = "twofinger";
      naturalScrolling = false;
      horizontalScrolling = true;
    };
  };

  time.timeZone = "America/Denver";

  users.defaultUserShell = "/run/current-system/sw/bin/fish";
}
