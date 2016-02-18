{
  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
    enablePepperPDF   = true;
    enableWideVine    = true;
  };

  packageOverrides = pkgs_: with pkgs_; {
    all-unstable = with pkgs; buildEnv {
      name = "all-unstable";
      paths = [

        # Docker
        bridge-utils
        python27Packages.docker_compose

        # Editors
        (emacsWithPackages (epkgs: [
          epkgs.flycheck
          epkgs.flycheck-haskell
          epkgs.helm
          epkgs.helm-projectile
          epkgs.ido-ubiquitous
          epkgs.markdown-mode
          epkgs.magit
          epkgs.mwim
          epkgs.neotree
          epkgs.nix-mode
          epkgs.projectile
          epkgs.tabbar
          epkgs.ws-butler
          epkgs.yaml-mode
        ]))
        idea."idea-ultimate"

        # Haskell
        haskellPackages.stack

        # Web browsers
        chromium
      ];
    };
  };
}
