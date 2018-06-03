{ emacsWithPackages, ... }:
(emacsWithPackages (emacsPackages: with {
  elpa = emacsPackages.elpaPackages;
  melpa = emacsPackages.melpaPackages;
}; with melpa; [
  back-button
  centered-window-mode
  diff-hl
  elixir-mode
  fill-column-indicator
  flycheck
  ghc
  helm
  helm-projectile
  ido-ubiquitous
  intero
  js2-mode
  json-mode
  markdown-mode
  magit
  mwim
  neotree
  nix-sandbox
  nix-mode
  elpa.org
  projectile
  purescript-mode
  python-mode
  scala-mode
  scss-mode
  tabbar
  transpose-frame
  web-mode
  ws-butler
  yaml-mode
]))
