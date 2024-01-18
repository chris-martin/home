{ pkgs, lib, config, ... }: {

  imports = [ ../base ];

  boot = {
    tmp.cleanOnBoot = true;
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" ];
      luks.devices.root = {
        device = "/dev/nvme0n1p3";
        preLVM = true;
      };
    };
    kernelModules = [ "kvm-intel" "snd-hda-intel" ];
    kernelParams = [ "pci=nocrs" ];
    loader = {
      grub.device = "/dev/nvme0n1";
      systemd-boot.enable = false;
    };
  };

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/82b44344-492e-4e6f-8bdf-e9f92d98c4ca";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/6490-0447";
      fsType = "vfat";
    };
  };

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    bluetooth.enable = false;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  networking = {
    hostName = "renzo";
    networkmanager.enable = true;
  };

  nix.settings = {
    trusted-users = [ "@wheel" ];
    max-jobs = 1;
  };

  services.xserver = {
    enable = true;

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.autoLogin = {
      enable = true;
      user = "chris";
    };

    displayManager.sessionCommands = ''
      dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font "'Monospace 14'"
      dconf write /org/gnome/desktop/interface/font-name "'Cantarell 13'"
      dconf write /org/gnome/desktop/interface/document-font-name "'Lato Medium 13'"
      dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'Lato Bold 13'"

      dconf write /org/gnome/desktop/wm/preferences/resize-with-right-button true
      dconf write /org/gnome/desktop/wm/preferences/mouse-button-modifier "'<Alt>'"
    '';
  };

  swapDevices = [ ];

  system.stateVersion = "19.03";

  users.extraUsers.chris = {
    isNormalUser = true;
    description = "Chris Martin";
    extraGroups = [
      "audio"
      "disk"
      "docker"
      "networkmanager"
      "plugdev"
      "systemd-journal"
      "wheel"
      "vboxusers"
      "video"
    ];
    uid = 1000;
  };
}
