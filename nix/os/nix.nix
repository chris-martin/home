{
  nix.settings.autoOptimiseStore = true;

  # https://stackoverflow.com/questions/33180784
  nix.settings.extraOptions = "binary-caches-parallel-connections = 5";
}
