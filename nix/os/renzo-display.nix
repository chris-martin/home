{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      sessionPackages = [
        (pkgs.plasma-workspace.overrideAttrs (old: { passthru.providedSessions = ["plasmawayland"]; }))
      ];
    };
    desktopManager.plasma5 = {
      enable = true;
      #runUsingSystemd = true;
    };
  };
}
