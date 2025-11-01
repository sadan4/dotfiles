{
	pkgs,
	config,
	...
}: {
	home = {
		packages = with pkgs; [
			neovim
		];
		file = {
			nvim = {
				recursive = true;
				source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/light.config";
				target = "./.config/nvim";
			};
		};
		sessionVariables = {
			EDITOR = "nvim";
			MANPAGER = "nvim +Man!";
		};
	};
}
