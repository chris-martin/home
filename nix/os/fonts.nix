{ pkgs, ... }:
{
  fonts.enableFontDir = true;
  fonts.enableGhostscriptFonts = true;

  i18n.consoleFont = "Fira Mono";

  fonts.fonts = [
    pkgs.corefonts
    pkgs.fira
    pkgs.fira-code
    pkgs.fira-mono
    pkgs.lato
    pkgs.google-fonts
    pkgs.inconsolata
    pkgs.rollandin-emilie
    pkgs.symbola
    pkgs.ubuntu_font_family
    pkgs.unifont
    pkgs.vistafonts
  ];
}
