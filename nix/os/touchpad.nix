{ ... }:
{
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.minSpeed = "0.8";
  services.xserver.synaptics.maxSpeed = "1.4";
  services.xserver.synaptics.accelFactor = "0.05";
  services.xserver.synaptics.tapButtons = false;
  services.xserver.synaptics.twoFingerScroll = true;

  services.xserver.libinput.enable = false;
}
