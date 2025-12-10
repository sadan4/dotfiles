{
	pkgs,
	config,
	...
}: let
	nvim = pkgs.pinned.neovim;
in {
	imports = [
		./pinned.nix
	];
	home = {
		packages = with pkgs; [
			nvim
			# formatter for this repo (and nix in general)
			alejandra
			# vim is useful for larger files where neovim just hangs
			vim
			nvimpager
		];
		file = {
			nvim = {
				recursive = true;
				source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
				target = "./.config/nvim";
			};
		};
		sessionVariables = {
			EDITOR = "${nvim}/bin/nvim";
			MANPAGER = "nvim +Man!";
			PAGER = "nvimpager";
		};
	};
}
