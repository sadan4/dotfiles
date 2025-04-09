# Edit this configuration file to define what should be installed onconfigurati
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# { config, lib, pkgs, inputs, ... }:
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../common/users/meyer-wsl
    ../../common/systemModules/wsl.nix
    ../../common/systemModules/kernel.nix
    ../../common/systemModules/crypt.nix
    ../../common/systemModules/stylix.nix
  ];

  hardware.i2c.enable = true;

  networking.hostName = "arm-laptop-evo4b5"; # Define your hostname.

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Set your time zone.
  time.timeZone = "America/New_York";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    ddcutil
    i2c-tools
    fuse
    nano
    curl
    wget
    ripgrep
    tldr
    libnotify
    file
  ];
  #LD fix
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
    alsa-lib
    expat
    mesa
    libxkbcommon
    xorg.libxcb
    xorg.libXrandr
    xorg.libXfixes
    xorg.libXext
    xorg.libXdamage
    xorg.libXcomposite
    xorg.libX11
    cairo
    pango
    gtk3
    libdrm
    cups
    at-spi2-atk
    lzo
    dbus
    nspr
    nss
    glib
    curlWithGnuTls
    fuse
    fuse3
    mimalloc
  ];
  programs.ssh.startAgent = true;
  # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
