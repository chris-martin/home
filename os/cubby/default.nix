{ config, lib, pkgs, ... }: {

  imports = [ ../base ];

  boot = {
    cleanTmpDir = true;
    extraModulePackages = [ ];
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
    kernelModules = [ "kvm-intel" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/sda";
    };
  };

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';

  fileSystems = {
    "/" = {
      device = "/dev/vg/root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/sda2";
      fsType = "vfat";
    };
  };

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    bluetooth.enable = false;
  };

  networking = {
    hostName = "cubby";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ ];
  };

  nix.settings = {
    trusted-users = [ "@wheel" ];
    max-jobs = 8;
    build-cores = 0;
  };

  powerManagement.cpuFreqGovernor = "powersave";

  services.hoogle.enable = true;

  services.minecraft-server = {
    eula = true;
    openFirewall = true;
    declarative = true;
    serverProperties = {
      server-port = 43000;
      gamemode = "survival";
      motd = "Moronuki house Minecraft";
      enable-rcon = false;
      white-list = false;
      difficulty = "easy";
      online-mode = false;
    };
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

  system.stateVersion = "19.09";

  users.users = {
    chris = {
      isNormalUser = true;
      description = "Chris Martin";
      extraGroups = [ "wheel" ];
      uid = 1000;
    };
    julie = {
      isNormalUser = true;
      description = "Julie Moronuki";
      uid = 1001;
    };
  };
}
