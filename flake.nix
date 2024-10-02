#commit
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
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
        desktopIso = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            # ./boxes/desktop/configuration.nix
            # inputs.home-manager.nixosModules.default
            ({ pkgs, modulesPath, ... }: {
              imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
              boot.kernelPackages = pkgs.linuxPackages_testing;
            })
          ];
        };
        nix-desktop-evo4b5 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./boxes/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
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
