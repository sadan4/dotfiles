{
  config,
  stable,
  inputs,
  ...
}:
{
  nix = {
    settings = {
      extra-platforms = config.boot.binfmt.emulatedSystems;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    package = stable.nix;
    nixPath = [ "nixpkgs=${inputs.nixpkgs-unstable}" ];
  };
}
