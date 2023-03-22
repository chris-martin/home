{ pkgs, ... }:
{
  fonts.fontDir.enable = true;
  fonts.enableGhostscriptFonts = true;

  console.font = "Fira Mono";

  fonts.fonts = [
    pkgs.corefonts
    pkgs.fira
    pkgs.fira-code
    pkgs.fira-mono
    pkgs.lato
    # pkgs.google-fonts
    pkgs.inconsolata
    pkgs.profont
    pkgs.rollandin-emilie
    pkgs.source-sans-pro
    pkgs.source-serif-pro
    pkgs.symbola
    pkgs.ubuntu_font_family
    pkgs.unifont
    pkgs.vistafonts
  ];
}
