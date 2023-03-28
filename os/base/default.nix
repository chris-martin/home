{ pkgs, ... }: {
  imports = [
    ./essentials.nix
    ./cache.nix
    ./authorized-keys.nix
    ./display.nix
    ./nix.nix
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
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
  nixpkgs.config.allowUnfree = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
  services.dictd.enable = true;
  services.hoogle.packages = import ./hoogle-packages.nix;
  services.hoogle.port = 13723;
  services.monero.mining.address =
    "427YsNgWdfJ9VraWsLC6h4Rygqq1VozD8Q6JC2DoPcHzbRxo6xjtWHyF7B1PBYsqFN8R37itSYthm6xiaDxGoFdFLKnDMn7";
  services.monero.mining.threads = 1;
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.printing.enable = true;
  services.printing.drivers =
    [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
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
