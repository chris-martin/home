let
  mkCache = url: key: { inherit url key; };

  default = mkCache "https://cache.nixos.org"
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=";

  cachix = mkCache "https://cachix.cachix.org"
    "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM=";

  chris-martin = mkCache "https://chris-martin.cachix.org"
    "chris-martin.cachix.org-1:O/29OCGL8P7qk/NmEaZzzZk3DDmUfa9nGA74OrX9/1g=";

  ghcide-nix = mkCache "https://ghcide-nix.cachix.org"
    "ghcide-nix.cachix.org-1:ibAY5FD+XWLzbLr8fxK6n8fL9zZe7jS+gYeyxyWYK5c=";

  typeclasses = mkCache "https://typeclasses.cachix.org"
    "typeclasses.cachix.org-1:K8vVpme/5SO7t3YIlr+B0O9daHgHN56u2U0uIT1w+N8=";

  all = [
    default
    cachix
    chris-martin
    ghcide-nix
    typeclasses
  ];

in
  {
    nix.binaryCaches          = builtins.map (x: x.url) all;
    nix.binaryCachePublicKeys = builtins.map (x: x.key) all;
  }
