{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.corefonts
    pkgs.fira
    pkgs.fira-code
    pkgs.fira-mono
    pkgs.lato
    pkgs.merriweather
    pkgs.monoid
    (pkgs.google-fonts.override { fonts = [ "BioRhyme" ]; })
    pkgs.hasklig
    pkgs.helvetica-neue-lt-std
    pkgs.inconsolata
    pkgs.luculent
    pkgs.profont
    pkgs.source-sans-pro
    pkgs.source-serif-pro
    pkgs.symbola
    pkgs.ubuntu_font_family
    pkgs.unifont
    pkgs.vistafonts
  ];
}
