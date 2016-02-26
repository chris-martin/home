#
# Renzo is a Dell XPS 13 non-touch, circa early 2016.
#

{ config, pkgs, ... }: {

  imports = [ ./sys-base.nix ];

  networking.hostName = "renzo";

  boot = {
    initrd.luks.devices = [{
      name   = "root";
      device = "/dev/nvme0n1p3";
      preLVM = true;
    }];
    loader = {
      grub.device = "/dev/nvme0n1";
      gummiboot.enable = false;
    };
    kernelPackages = pkgs.linuxPackages_4_4;
    kernelModules  = ["snd-hda-intel"];
  };

  services.xserver.synaptics = {
    enable      = true;
    accelFactor = "0.04";
  };

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';
}
