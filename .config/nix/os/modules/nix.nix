{
    nix.settings = {
        auto-optimise-store = true;
        nix-path = [ "/home/chris/.config/nix-path" ];
        experimental-features = [ "nix-command" "flakes" ];
        trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
            "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
            "chris-martin.cachix.org-1:O/29OCGL8P7qk/NmEaZzzZk3DDmUfa9nGA74OrX9/1g="
            "typeclasses.cachix.org-1:K8vVpme/5SO7t3YIlr+B0O9daHgHN56u2U0uIT1w+N8="
        ];
    };
}
