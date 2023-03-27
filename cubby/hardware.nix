{ config, lib, pkgs, ... }:
{
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    boot = {
        initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
    };

    fileSystems = {
        "/" = { device = "/dev/vg/root"; fsType = "ext4"; };
        "/boot" = { device = "/dev/sda2"; fsType = "vfat"; };
    };

    swapDevices = [ ];

    powerManagement.cpuFreqGovernor = "powersave";
}
