{ pkgs, ... }:
{
    hardware = {
        pulseaudio.enable = true;
        pulseaudio.package = pkgs.pulseaudioFull;
        bluetooth.enable = false;
    };

    environment.etc."modprobe.d/alsa-base.conf".text = ''
      options snd-hda-intel index=1 model=dell-headset-multi
      options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
    '';

    # https://github.com/NixOS/nixpkgs/issues/24184
    services.acpid.enable = true;
    services.acpid.handlers.fixHeadphoneNoise = {
        event = "jack/headphone HEADPHONE plug";
        action = "${pkgs.alsaUtils}/bin/amixer -c0 sset 'Headphone Mic Boost' 10dB";
    };
}
