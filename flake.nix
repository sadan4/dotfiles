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
    nix-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nix-stable";
    };
    stylix-stable = {
        url = "github:danth/stylix/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nix-stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scripts = {
      inputs.scripts.follows = "nixpkgs";
      url = "github:sadan4/scripts";
    };
    stylix = {
        url = "github:danth/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      nix-stable,
      ...
    }@inputs:
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
            (
              {
                pkgs,
                modulesPath,
                lib,
                ...
              }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
                boot.kernelPackages = pkgs.linuxPackages_latest;
                boot.supportedFilesystems = lib.mkForce [
                  "btrfs"
                  "reiserfs"
                  "vfat"
                  "f2fs"
                  "xfs"
                  "ntfs"
                  "cifs"
                  "ext4"
                ];
              }
            )
          ];
        };
        nix-desktop-evo4b5 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./boxes/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
          ];
        };
        arm-laptop-evo4b5 = nix-stable.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inputs = inputs // {
              nixpkgs = nix-stable;
              home-manager = inpus.home-manager-stable;
              stylix = inputs.stylix-stable;
            };
            unstable = nixpkgs;
          };
          modules = [
            ./boxes/wsl/configuration.nix
            inputs.home-manager-stable.nixosModules.default
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
