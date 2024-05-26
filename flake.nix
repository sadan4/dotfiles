#commit
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs:
    # let
    # boxes = [
    # "default"
    # ];
    # forAllSystems = nixpkgs.lib.genAttrs boxes;
    # in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./boxes/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
      # nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [
      #     ./boxes/desktop/configuration.nix
      #     inputs.home-manager.nixosModules.default
      #   ];
      # };
      # cpkg = forAllSystems(system: import ./customPackages);
    };

}
