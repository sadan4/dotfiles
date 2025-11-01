{pkgs, ...}: {
	home = {
		packages = with pkgs; [
			rofi
		];
		file = {
			rofi = {
				recursive = true;
				source = ../../../dotfiles/rofi;
				target = "./.config/rofi";
			};
		};
	};
	programs = {
		plasma = {
			hotkeys = {
				commands = {
					"rofi" = {
						name = "rofi";
						key = "Alt+P";
						command = "rofi -show drun";
					};
				};
			};
		};
	};
}
