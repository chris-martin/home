{
  nix.autoOptimiseStore = true;

  # https://stackoverflow.com/questions/33180784
  nix.extraOptions = "binary-caches-parallel-connections = 5";
}
