let
  mkCache = url: key: { inherit url key; };

  default = mkCache "https://cache.nixos.org"
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=";

  cachix = mkCache "https://cachix.cachix.org"
    "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM=";

  chris-martin = mkCache "https://chris-martin.cachix.org"
    "chris-martin.cachix.org-1:O/29OCGL8P7qk/NmEaZzzZk3DDmUfa9nGA74OrX9/1g=";

  reflex = mkCache "https://nixcache.reflex-frp.org"
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=";

  all = [ default cachix chris-martin reflex ];

in
  {
    nix.binaryCaches          = builtins.map (x: x.url) all;
    nix.binaryCachePublicKeys = builtins.map (x: x.key) all;
  }
