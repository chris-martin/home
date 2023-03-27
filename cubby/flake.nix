{
  inputs = {
    # Generally where most stuff comes from
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    # For a few packages where the very latest thing is needed
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Where home-manager and all its options come from
    home-manager.url = "github:nix-community/home-manager";

    # localFlakes
    firefox.url = "path:/home/chris/.config/nix/firefox";
    vscode.url = "path:/home/chris/.config/nix/vscode";

    nixosBase.url = "path:/home/chris/.config/nix/nixos-base";
    home.url = "path:/home/chris/.config/nix/home";
    hoogle.url = "path:/home/chris/.config/nix/hoogle";
  };

  outputs = inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
    in {
      nixosConfigurations.cubby = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (inputs) home;
          inherit pkgsUnstable;
          localFlakes = { inherit (inputs) firefox vscode; };
        };
        modules = [
          inputs.home-manager.nixosModule
          inputs.hoogle.nixosModule

          ./audio.nix
          ./boot.nix
          ./display.nix
          ./hardware.nix
          ./misc.nix
          ./networking.nix
          ./nix.nix
          ./users.nix

          (inputs.nixosBase.path + /authorized-keys.nix)
          (inputs.nixosBase.path + /avahi.nix)
          (inputs.nixosBase.path + /cache.nix)
          (inputs.nixosBase.path + /display.nix)
          (inputs.nixosBase.path + /dns.nix)
          (inputs.nixosBase.path + /essentials.nix)
          (inputs.nixosBase.path + /fonts.nix)
          (inputs.nixosBase.path + /fuse.nix)
          (inputs.nixosBase.path + /keyboard.nix)
          (inputs.nixosBase.path + /location.nix)
          (inputs.nixosBase.path + /nix.nix)
          (inputs.nixosBase.path + /printing.nix)
          (inputs.nixosBase.path + /ssh.nix)
          (inputs.nixosBase.path + /web-browsers.nix)
        ];
      };
    };
}
