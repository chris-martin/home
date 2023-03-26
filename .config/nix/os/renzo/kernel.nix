{ pkgs, ... }:
{
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelModules  = ["snd-hda-intel"];
    boot.kernelParams = ["pci=nocrs"];
}
