let os-flake = "/home/chris/.config/nix";
in {
  programs.fish = {
    shellAbbrs = {
      os-switch = "sudo time nixos-rebuild --flake ${os-flake} switch";
      os-update = "nix flake lock ${os-flake} --update-input";
      os-inputs = "nix flake info ${os-flake}";
    };
  };
}
