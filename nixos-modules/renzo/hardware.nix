{ config, lib, pkgs, ... }:

{
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/82b44344-492e-4e6f-8bdf-e9f92d98c4ca";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/6490-0447";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];
}
