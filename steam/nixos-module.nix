{ steam }: {
  environment.systemPackages = [ steam ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
