{ ... }: {
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      accelSpeed = "0.01";
      tapping = false;
      scrollMethod = "twofinger";
      naturalScrolling = false;
      horizontalScrolling = true;
    };
  };
}
