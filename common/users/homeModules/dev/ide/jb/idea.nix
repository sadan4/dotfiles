{ pkgs, ... }: {
  imports = [
    ../../../pinned.nix
  ];
  home = {
    packages = with pkgs.pinned; [
      idea-ultimate
    ];
  };
}
