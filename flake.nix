{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      # inputs.home-manager.follows = "home-manager-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    scripts = {
      url = "github:sadan4/scripts";
    };
    chrome-pak = {
      url = "github:sadan4/chrome-pak-customizer";
    };
    ceserver = {
      url = "github:sadan4/ceserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-alien.url = "https://flakehub.com/f/thiagokokada/nix-alien/0.1.384.tar.gz";
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cppman = {
      url = "github:sadan4/cppman";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixos-wsl,
      nixpkgs,
      nixpkgs-unstable,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [ "x86_64-linux" ];
      perSystem = { config, ... }: { };
      flake = {
        homeConfigurations = {
          nixd = inputs.home-manager-unstable.lib.homeManagerConfiguration {
            pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
            modules = [
              {
                home = {
                  stateVersion = "24.05";
                  username = "nixd";
                  homeDirectory = "/dev/null";
                };
              }
              (
                { pkgs, ... }:
                {
                  wayland.windowManager.hyprland.enable = true;
                  home = {
                    packages = with pkgs; [ nixd ];
                  };
                }
              )
            ];
          };
        };
        nixosConfigurations = {
          nixd = nixpkgs-unstable.lib.nixosSystem { };
          serverpc = nixpkgs-unstable.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              isWsl = false;
              inherit inputs;
              stable = import nixpkgs {
                inherit system;
                config = {
                  allowUnfree = true;
                };
              };
            };
            modules = [
              (
                { pkgs, ... }:
                {
                  _module.args = {
                    unstable = pkgs;
                  };
                }
              )
              ./boxes/serverpc/configuration.nix
              inputs.home-manager-unstable.nixosModules.default
            ];
          };
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
          nix-desktop-evo4b5 = nixpkgs.lib.nixosSystem rec {
            specialArgs = {
              isWsl = false;
              inherit inputs;
              unstable = import nixpkgs-unstable {
                inherit system;
                config = {
                  allowUnfree = true;
                };
              };
            };
            system = "x86_64-linux";
            modules = [
              (
                { pkgs, ... }:
                {
                  _module.args = {
                    stable = pkgs;
                  };
                }
              )
              ./boxes/desktop/configuration.nix
              inputs.home-manager.nixosModules.default
              inputs.nix-index-database.nixosModules.nix-index
              { programs.nix-index-database.comma.enable = true; }
            ];
          };
          arm-laptop-evo4b5 = nixpkgs.lib.nixosSystem rec {
            system = "aarch64-linux";
            specialArgs = {
              isWsl = false;
              inputs = inputs // {
                nixpkgs = nixpkgs;
                home-manager = inputs.home-manager-stable;
              };
              unstable = import nixpkgs-unstable {
                inherit system;
                config = {
                  allowUnfree = true;
                };
              };
            };
            modules = [
              (
                { pkgs, ... }:
                {
                  _module.args = {
                    stable = pkgs;
                  };
                }
              )
              ./boxes/wsl/configuration.nix
              inputs.home-manager-stable.nixosModules.default
              nixos-wsl.nixosModules.wsl
            ];
          };
          wsl-desktop-evo4b5 = nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
              isWsl = true;
              unstable = import nixpkgs-unstable {
                inherit system;
                config = {
                  allowUnfree = true;
                };
              };
            };
            modules = [
              (
                { pkgs, ... }:
                {
                  _module.args = {
                    stable = pkgs;
                  };
                }
              )
              nixos-wsl.nixosModules.default
              ./boxes/wsl-desktop-evo4b5/configuration.nix
              inputs.home-manager.nixosModules.default
              inputs.nix-index-database.nixosModules.nix-index
              { programs.nix-index-database.comma.enable = true; }
            ];
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
      };
    };
}
