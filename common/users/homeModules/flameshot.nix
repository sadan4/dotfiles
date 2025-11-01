{
	config,
	pkgs,
	...
}: {
	imports = [./stable.nix];
	# needed to workaround https://github.com/nix-community/home-manager/issues/2064
	systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = ["graphical-session-pre.target"];
		};
	};
	programs = {
		plasma = {
			hotkeys = {
				commands = {
					"flameshot" = {
						name = "flameshot";
						key = "Print";
						command = "flameshot gui";
					};
				};
			};
		};
	};
	services = {
		flameshot = {
			enable = true;
			package = pkgs.stable.flameshot;
			settings = {
				General = {
					savePath = "/home/${config.home.username}/ss/";
					saveAsFileExtension = ".png";
					showDesktopNotification = false;
				};
			};
		};
	};
}
