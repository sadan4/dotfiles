# Edit this configuration file to define what should be installed onconfiguraticonfig
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  inputs,
  unstable,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../common/systemModules/boot.nix
    ../../common/systemModules/folding.nix
    ../../common/systemModules/kernel.nix
    ../../common/systemModules/audio.nix
    ../../common/systemModules/kde.nix
    ../../common/systemModules/tailscale.nix
    ../../common/systemModules/gaming.nix
    ../../common/systemModules/crypt.nix
    ../../common/systemModules/printing.nix
    ../../common/systemModules/stylix.nix
    ../../common/systemModules/debug.nix
    ../../common/systemModules/nix.nix
    # USERS
    ../../common/users/meyer
  ];
  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  hardware.i2c.enable = true;
  hardware.amdgpu.opencl.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.bluetooth.enable = true;
  networking.hostName = "nix-desktop-evo4b5"; # Define your hostname.
  environment.sessionVariables = {
    HOSTNAME = config.networking.hostName;
  };
  # Set your time zone.
  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  services = {
    teamviewer.enable = true;
    usbmuxd.enable = true;
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    (inputs.nix-alien.packages.${pkgs.system}.nix-alien)
    ddcutil
    clinfo
    i2c-tools
    fuse
    ifuse
    unstable.gcc
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
    unstable.libgcc.lib
    graalvm-ce
    zlib.static
    libGL
    glfw3-minecraft
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
    gtk3-x11
    libdrm
    cups
    at-spi2-atk
    lzo
    dbus
    nspr
    nss
    curlWithGnuTls
    fuse
    fuse3
    mimalloc
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
