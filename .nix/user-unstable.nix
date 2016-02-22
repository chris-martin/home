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
        (emacsWithPackages (emacs-pkgs_: with emacs-pkgs_; [
          diff-hl
          flycheck
          flycheck-haskell
          melpaPackages.helm
          melpaPackages.helm-projectile
          ido-ubiquitous
          markdown-mode
          magit
          mwim
          neotree
          nix-mode
          projectile
          tabbar
          ws-butler
          yaml-mode
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
