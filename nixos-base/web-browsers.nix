{ pkgs, ... }: {
  environment.systemPackages = [
    # pkgs.firefox
  ];
  services.gnome.gnome-browser-connector.enable = true;
}
