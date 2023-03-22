{
    boot = {
        initrd.luks.devices.root = {
            device = "/dev/nvme0n1p3";
            preLVM = true;
        };

        loader = {
            grub.device = "/dev/nvme0n1";
            systemd-boot.enable = false;
        };

        cleanTmpDir = true;
    };
}
