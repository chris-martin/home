{
  imports = [
    ../base

    ./audio.nix
    ./boot.nix
    ./display.nix
    ./hardware.nix
    ./minecraft-server.nix
    ./networking.nix
    ./nix.nix
    ./users.nix
  ];

  services.hoogle.enable = true;
  system.stateVersion = "19.09";
}
