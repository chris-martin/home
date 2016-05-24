#
# Renzo is a Dell XPS 13 non-touch, circa early 2016.
#

{ config, pkgs, ... }: {

  imports = [ ../boxTypes/desktop.nix ];

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
    extraKernelParams = ["pci=nocrs"];
  };

  nixpkgs.config.virtualbox.enableExtensionPack =
    let _ = pkgs.fetchurl {
      url = "http://download.virtualbox.org/virtualbox/5.0.12/Oracle_VM_VirtualBox_Extension_Pack-5.0.12-104815.vbox-extpack";
      sha256 = "0v933g6sk1akfm48xwdd0z61164by7llj8974lriipvz5d2wh6xc";
    }; in true;

  services.xserver.synaptics = {
    enable      = true;
    minSpeed    = "0.8";
    maxSpeed    = "1.4";
    accelFactor = "0.05";
  };

  services.mongodb.enable = true;

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';
}
