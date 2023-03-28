{
  imports = [
    ../nixos-base
    ../hoogle

    ./audio.nix
    ./boot.nix
    ./display.nix
    ./hardware.nix
    ./minecraft-server.nix
    ./networking.nix
    ./nix.nix
    ./users.nix
  ];

  nixpkgs.config.allowUnfree = true;
  services.dictd.enable = true;
  services.hoogle.enable = true;
  system.stateVersion = "19.09";
}
