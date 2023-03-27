{
    inputs = {
        # Generally where most stuff comes from
        nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;

        # For a few packages where the very latest thing is needed
        nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;

        # Where home-manager and all its options come from
        home-manager.url = github:nix-community/home-manager;

        # localFlakes
        firefox.url = path:/home/chris/.config/nix/firefox;
        vscode.url = path:/home/chris/.config/nix/vscode;

        localModules.url = path:/home/chris/.config/nix/os/modules;
        home.url = path:/home/chris/.config/nix/home;
        hoogle.url = path:/home/chris/.config/nix/hoogle;
    };

    outputs = { self, nixpkgs, localModules, home, home-manager, nixpkgs-unstable, hoogle, ... }@args: {
        nixosConfigurations.renzo = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
                inherit home;
                pkgsUnstable = nixpkgs.legacyPackages.x86_64-linux;
                localFlakes = {
                    inherit (args) firefox vscode;
                };
            };
            modules = [
                home-manager.nixosModule
                hoogle.nixosModule

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
