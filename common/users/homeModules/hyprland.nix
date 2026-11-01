{
	pkgs,
	config,
	inputs,
	...
}: {
	imports = [inputs.caelestia-shell.homeManagerModules.default];
	programs.caelestia = {
		enable = true;
		# started from hyprland execs.lua
		systemd.enable = false;
	};
	home = {
		packages = with pkgs; [
			dunst
			waybar
		];
		file = {
			hypr = {
				recursive = true;
				source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/hypr2";
				target = "./.config/hypr";
			};
		};
	};
}
