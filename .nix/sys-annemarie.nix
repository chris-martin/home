{ config, pkgs, ... }: {

  imports = [ ./sys-base.nix ];

  networking.hostName = "annemarie";

  boot = {
    initrd.luks.devices = [{
      name   = "root";
      device = "/dev/sda3";
      preLVM = true;
    }];
    loader = {
      grub.device = "/dev/sda";
      gummiboot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services.xserver.synaptics = {
    enable          = true;
    tapButtons      = false;
    twoFingerScroll = true;
    minSpeed        = "0.75";
    maxSpeed        = "5.5";
    accelFactor     = "0.015";
    palmDetect      = true;
    palmMinWidth    = 3;
    scrollDelta     = 65;

    # Left edge is adjusted because palm detection isn't good
    # enough on the edges. This touchpad is off-center and my
    # left palm tends to graze it.
    additionalOptions = ''
      Option "AreaLeftEdge" "450"
    '';
  };
}
