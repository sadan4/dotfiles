# Edit this configuration file to define what should be installed onconfiguraticonfig
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common/systemModules/boot.nix
    ../../common/systemModules/kernel.nix
    ../../common/systemModules/tailscale.nix
    ../../common/systemModules/crypt.nix
    ../../common/systemModules/nix.nix
    ../../common/systemModules/sshd.nix
    ../../common/systemModules/nginx.nix
    ../../common/systemModules/tailscaleServer.nix
    ../../common/systemModules/cloudflared.nix
    ../../common/systemModules/jellyfin.nix
    ../../common/systemModules/zipline.nix
    # for compat with some home modules
    ../../common/systemModules/stylix.nix
    # USERS
    ../../common/users/meyer-server
  ];
  hardware.i2c.enable = true;
  networking.hostName = "serverpc"; # Define your hostname.
  environment.sessionVariables = {
    HOSTNAME = config.networking.hostName;
  };
  # Set your time zone.
  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    nvtopPackages.full
    curl
    wget
    ripgrep
    file
  ];
  #LD fix
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
