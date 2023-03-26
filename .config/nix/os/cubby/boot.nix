{ config, pkgs, ... }:
{
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            grub.device = "/dev/sda";
        };

        cleanTmpDir = true;
    };
}
