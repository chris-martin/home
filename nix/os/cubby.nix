#
# Cubby is an Intel NUC Kit NUC6i7KYK Mini PC from mid-2017.
#

{ config, pkgs, ... }:

{
  nixpkgs.config = import ../config.nix;

  services.r53-ddns = { enable = true; zoneID = "ZYH50EMOKUVH6"; domain = "chris-martin.org"; hostname = "home"; environmentFile = "/home/chris/secrets/ddns"; };

  # https://github.com/NixOS/nixpkgs/issues/103746
  #services.xserver.displayManager.autoLogin = { enable = true; user = "chris"; };

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];

  services.postfix.enable = true;

  services.monero = {
    #enable = true;
    #mining.enable = true;
    mining.address = "427YsNgWdfJ9VraWsLC6h4Rygqq1VozD8Q6JC2DoPcHzbRxo6xjtWHyF7B1PBYsqFN8R37itSYthm6xiaDxGoFdFLKnDMn7";
    mining.threads = 1;
  };

  imports = [
    ./hardware.nix
    ./essentials.nix
    ./kitchen-sink.nix
    ./locale.nix
    ./fonts.nix
    ./keyboard.nix
    ./hoogle.nix
    ./avahi.nix
    ./steam.nix
    ./dns.nix
    ./web-browsers.nix
    ./display.nix
    ./cubby-display.nix
    ./ledger.nix
    ./cache.nix
    ./nix.nix
    #./direnv.nix
    #./minecraft-server.nix
  ];

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  nix.settings.trusted-users = [ "@wheel" ];

  nix.settings.max-jobs = 8;
  nix.settings.build-cores = 0;

  time.timeZone = "America/Denver";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  networking.hostName = "cubby";
  networking.networkmanager.enable = true;

  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 8000 5901 ];

  # services.redshift.enable = true;
  location.provider = "geoclue2";

  #services.localtime.enable = true;

  services.dictd.enable = true;

  #services.xserver.libinput.mouse.buttonMapping = "3 2 1 4 5 6 7 0 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32";

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  system.stateVersion = "19.09";

  systemd.services.tigervnc = {
    enable = true;
    wantedBy = ["default.target"];
    serviceConfig = {
      User = "chris";
      ExecStart = "${pkgs.writeShellApplication {
        name = "tigervnc";
        runtimeInputs = [pkgs.tigervnc pkgs.openbox];
        text = ''
          Xvnc :1 -PasswordFile /home/chris/.vnc/passwd &
          env DISPLAY=":1" PATH="/etc/profiles/per-user/chris/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH" openbox --config-file ${./openbox.xml}
          fg
        '';
      }}/bin/tigervnc";
    };
  };


  #-----------------------------------------------------------------------------
  #  Users
  #-----------------------------------------------------------------------------

  users.users = {
    chris = {
      isNormalUser = true;
      description = "Chris Martin";
      extraGroups = ["wheel"];
      uid = 1000;
      openssh.authorizedKeys.keys = import ./keys.nix;
      shell = pkgs.fish;
    };
    julie = {
      isNormalUser = true;
      description = "Julie Moronuki";
      uid = 1001;
    };
  };


  #-----------------------------------------------------------------------------
  #  Boot
  #-----------------------------------------------------------------------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";
  #boot.kernelParams = [ "nomodeset" ];
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.cleanTmpDir = true;


  #-----------------------------------------------------------------------------
  #  Audio
  #-----------------------------------------------------------------------------

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  hardware.bluetooth.enable = false;

  environment.etc."modprobe.d/alsa-base.conf".text = ''
    options snd-hda-intel index=1 model=dell-headset-multi
    options snd-hda-intel index=0 model=auto vid=8086 pid=9d70
  '';

}
