{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.firefox-bin
    pkgs.google-chrome
  ];
  services.xserver.displayManager.sessionCommands = ''
    xdg-settings set default-web-browser chromium.desktop
  '';
}
