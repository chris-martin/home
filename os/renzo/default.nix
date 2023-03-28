{
  imports = [
    ../base
  ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "snd-hda-intel" ];
    kernelParams = [ "pci=nocrs" ];
  };

  system.stateVersion = "19.03";

          ./audio.nix
          ./boot.nix
          ./display.nix
          ./kernel.nix
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
          (inputs.nixosBase.path + /touchpad.nix)
          (inputs.nixosBase.path + /web-browsers.nix)
        ];
      };
    };
}
