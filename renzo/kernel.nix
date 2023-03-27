{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "snd-hda-intel" ];
    kernelParams = [ "pci=nocrs" ];
  };
}
