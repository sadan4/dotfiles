# Edit this configuration file to define what should be installed onconfiguraticonfig
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

let
  _v = import ../../common/programs/virt.nix { };
in
{
  fileSystems."/mnt/d" = {
    device = "/dev/disks/by-uuid/A02A12F22A12C566";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
    ];
  };
  fileSystems."/mnt/c" = {
    device = "/dev/disks/by-uuid/046C2BB16C2B9D04";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
      "noauto"
    ];
  };
  fileSystems."/mnt/f" = {
    device = "/dev/disks/by-uuid/2E06B65306B61C31";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
    ];
  };
  fileSystems."/mnt/h" = {
    device = "/dev/disks/by-uuid/E0A4F8C1A4F89B6C";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
    ];
  };
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
  boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
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
  services.desktopManager.plasma6.enable = true;
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    enable = true;
    displayManager.sddm = {
      enable = true;
    };
  };
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    hplip
  ];
  virtualisation = _v;
  # Enable the X11 windowing system.
  # servives.desktopManager.plasma6.enable = true;
  # services.desktopManager.plasma6.enable = true;



  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable sound.
  # sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.



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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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
