{
  config,
  unstable,
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
    package = unstable.nix;
    nixPath = [ "nixpkgs=${inputs.nixpkgs-unstable}" ];
  };
}
