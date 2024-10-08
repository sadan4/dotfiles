# Edit this configuration file to define what should be installed onconfigurati
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# { config, lib, pkgs, inputs, ... }:
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/meyer/.config/sops/age/keys.txt";
  sops.secrets.password.neededForUsers = true;
  wsl.enable = true;
  wsl.defaultUser = "meyer";
  # Use the systemd-boot EFI boot loader.
  users.users.meyer = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.password.path;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "input"
      "tty"
    ];
    shell = pkgs.zsh;
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "meyer" = import ./home.nix;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_zen;
  hardware.i2c.enable = true;
  networking.hostName = "nix-wsl"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  # Enable the X11 windowing system.
  # servives.desktopManager.plasma6.enable = true;
  # services.desktopManager.plasma6.enable = true;



  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable sound.
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.



  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;



  # networking.nameservers = ["10.0.0.97" "1.1.1.1"];
  networking.nameservers = [ "10.0.0.97" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ddcutil
    i2c-tools
    # python311
    # python311Packages.evdev
    # python311Packages.xlib
    gcc
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    wget
    git
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
    pkgs.curlWithGnuTls
  ];
  programs.ssh.startAgent = true;
  # programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

  programs.gnupg.agent = {
    enable = true;
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
