{ pkgs }:
{

  nix.binaryCaches = [
    "https://cachix.cachix.org"
  ];

  nix.binaryCachePublicKeys = [
    "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
  ];

}
