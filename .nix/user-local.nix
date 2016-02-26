{
  allowUnfree = true;

  packageOverrides = pkgs_: with pkgs_; {
    all-local = with pkgs; buildEnv {
      name = "all-local";
      paths = [
        steam
      ];
    };
  };
}
