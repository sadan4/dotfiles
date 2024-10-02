# Edit this configuration file to define what should be installed onconfiguraticonfig
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

let
  _v = import ../../common/programs/virt.nix { };
  wireshark = import ../../common/programs/wireshark.nix { };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common/modules/audio.nix
      ../../common/modules/kde.nix
      inputs.sops-nix.nixosModules.sops
    ];
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/meyer/.config/sops/age/keys.txt";
  sops.secrets.password.neededForUsers = true;
  users.users.meyer = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.password.path;
    extraGroups = [
      "wireshark"
      "kvm"
      "libvirtd"
      "wheel" # Enable ‘sudo’ for the user.
      "audio"
      "sound"
      "video"
      "networkmanager"
      "input"
      "tty"
      "plugdev"
    ];
    shell = pkgs.zsh;
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "meyer" = import ./home.nix;
    };
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device = "nodev";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # add user to "openrazer" group
  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "meyer" ];
  hardware.i2c.enable = true;
  hardware.xpadneo.enable = true;
  hardware.amdgpu.opencl.enable = true;
  hardware.bluetooth.enable = true;
  services.tailscale.enable = true;
  networking.hostName = "nix-desktop-evo4b5"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.

  # };

  services = {
    teamviewer.enable = true;
    avahi.enable = true;
    usbmuxd.enable = true;
  };
  services.xserver.videoDrivers = ["amdgpu"];
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    hplip
  ];
  virtualisation = _v;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.



  programs = {
    inherit wireshark;
  };
  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
  nixpkgs.config.allowUnfree = true;



  # networking.nameservers = ["10.0.0.97" "1.1.1.1"];
  networking.nameservers = [ "10.0.0.97" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    clinfo
    fuse
    ifuse
    ddcutil
    i2c-tools
    # python311
    # python311Packages.evdev
    # python311Packages.xlib
    gcc
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    wget
    ripgrep
    tldr
    gnupg
    openssh
    pinentry-curses
    pinentry
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
    libstdcxx5
  ];
  programs.ssh.startAgent = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

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
