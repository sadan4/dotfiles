{ unstable, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit unstable;
    })
  ];
}
