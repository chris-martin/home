{
    inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
    inputs.nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    inputs.home-manager.url = github:nix-community/home-manager;
    inputs.localModules.url = path:/home/chris/.config/nix/os/modules;
    inputs.home.url = path:/home/chris/.config/nix/home;

    outputs = { self, nixpkgs, localModules, home, home-manager, nixpkgs-unstable }@args: {
        nixosConfigurations.renzo = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
                inherit home;
                pkgsUnstable = nixpkgs.legacyPackages.x86_64-linux;
            };
            modules = [
                home-manager.nixosModule

                ./audio.nix
                ./boot.nix
                ./display.nix
                ./kernel.nix
                ./hardware.nix
                ./misc.nix
                ./networking.nix
                ./nix.nix
                ./users.nix

                (localModules.path + /avahi.nix)
                (localModules.path + /cache.nix)
                (localModules.path + /display.nix)
                (localModules.path + /dns.nix)
                (localModules.path + /essentials.nix)
                (localModules.path + /fonts.nix)
                (localModules.path + /fuse.nix)
                (localModules.path + /keyboard.nix)
                (localModules.path + /location.nix)
                (localModules.path + /nix.nix)
                (localModules.path + /printing.nix)
                (localModules.path + /ssh.nix)
                (localModules.path + /touchpad.nix)
                (localModules.path + /web-browsers.nix)
            ];
        };
    };
}
