{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config.allowInsecurePredicate = (pkg: true);
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  imports = [
    ../homeModules/utils.nix
    ../homeModules/dev
    ../homeModules/dev/cpp.nix
    ../homeModules/dev/javascript.nix
    ../homeModules/dev/nix.nix
    ../homeModules/dev/python.nix
    ../homeModules/scripts
    ../homeModules/git/cli.nix
    ../homeModules/nvim.nix
    ../homeModules/sops.nix
    ../homeModules/zsh.nix
  ];

  home.username = "meyer";
  home.homeDirectory = "/home/meyer";

  home = {
    packages = with pkgs; [
      wslu
    ];
  };
  programs = {
    zsh = {
      # fix windows dirs beinng flashbangs
      # https://stackoverflow.com/questions/43147351/win-10-bash-shell-and-highlighting-of-the-directories-in-console/43147778#43147778
      initContent = ''
        export LS_COLORS="''${LS_COLORS}:ow=1;34:"
      '';
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
