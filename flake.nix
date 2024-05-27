#commit
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-wsl, ... }@inputs:
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
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./boxes/wsl/configuration.nix
            inputs.home-manager.nixosModules.default
            nixos-wsl.nixosModules.wsl
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
