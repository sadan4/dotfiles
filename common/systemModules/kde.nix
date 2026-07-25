{
	pkgs,
	lib,
	...
}: {
	programs = {
		ssh = {
			askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
		};
		gnupg = {
			agent = {
				pinentryPackage = pkgs.pinentry-gnome3;
			};
		};
		kdeconnect = {
			enable = true;
		};
	};
	# https://github.com/NixOS/nixpkgs/issues/126590#issuecomment-3194531220
	# fix massive lag on KDE plasma caused by $XDG_DATA_DIRS being ~11k chars long
	# this takes it down to ~1.1k
	# removed because it's not worth the cache misses
	services = {
		desktopManager = {
			plasma6 = {
				enable = true;
			};
		};
		displayManager = {
			sddm = {
				wayland = {
					enable = false;
				};
				enable = true;
				autoNumlock = true;
			};
		};
		xserver = {
			enable = true;
		};
	};
}
