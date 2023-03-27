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

    outputs = inputs:
      let
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        pkgsUnstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
      in
      {
        nixosConfigurations.renzo = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
                inherit (inputs) home;
                inherit pkgsUnstable;
                localFlakes = {
                    inherit (inputs) firefox vscode;
                };
            };
            modules = [
                inputs.home-manager.nixosModule
                inputs.hoogle.nixosModule

                ./audio.nix
                ./boot.nix
                ./display.nix
                ./kernel.nix
                ./hardware.nix
                ./misc.nix
                ./networking.nix
                ./nix.nix
                ./users.nix

                (inputs.localModules.path + /avahi.nix)
                (inputs.localModules.path + /cache.nix)
                (inputs.localModules.path + /display.nix)
                (inputs.localModules.path + /dns.nix)
                (inputs.localModules.path + /essentials.nix)
                (inputs.localModules.path + /fonts.nix)
                (inputs.localModules.path + /fuse.nix)
                (inputs.localModules.path + /keyboard.nix)
                (inputs.localModules.path + /location.nix)
                (inputs.localModules.path + /nix.nix)
                (inputs.localModules.path + /printing.nix)
                (inputs.localModules.path + /ssh.nix)
                (inputs.localModules.path + /touchpad.nix)
                (inputs.localModules.path + /web-browsers.nix)
            ];
        };
    };
}
