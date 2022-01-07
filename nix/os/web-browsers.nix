{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.firefox
  ];
  services.xserver.displayManager.sessionCommands = ''
    xdg-settings set default-web-browser firefox.desktop
  '';
}
