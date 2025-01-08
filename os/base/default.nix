{ pkgs, ... }: {

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = [ pkgs.corefonts pkgs.fira-mono ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.dictd.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
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

  users.defaultUserShell = "/run/current-system/sw/bin/fish";
}
