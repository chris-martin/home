{ config, lib, pkgs, ... }: {

  imports = [
    ../base
    ./audio.nix
    ./display.nix
    ./minecraft-server.nix
  ];

  boot = {
    cleanTmpDir = true;
    extraModulePackages = [ ];
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
    kernelModules = [ "kvm-intel" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/sda";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/vg/root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/sda2";
      fsType = "vfat";
    };
  };

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  networking = {
    hostName = "cubby";
    networkmanager.enable = true;
    firewall.allowPing = true;
    firewall.allowedTCPPorts = [ ];
  };

  nix.settings = {
    trusted-users = [ "@wheel" ];
    max-jobs = 8;
    build-cores = 0;
  };

  powerManagement.cpuFreqGovernor = "powersave";

  services.hoogle.enable = true;

  swapDevices = [ ];

  system.stateVersion = "19.09";

  users.users = {
    chris = {
      isNormalUser = true;
      description = "Chris Martin";
      extraGroups = [ "wheel" ];
      uid = 1000;
    };
    julie = {
      isNormalUser = true;
      description = "Julie Moronuki";
      uid = 1001;
    };
  };
}
