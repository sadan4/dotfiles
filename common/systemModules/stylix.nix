{
	inputs,
	pkgs,
	...
}: let
	oldPkgs = (
		import
		(builtins.fetchGit {
				# Descriptive name to make the store path easier to identify
				name = "my-old-revision";
				url = "https://github.com/NixOS/nixpkgs/";
				ref = "refs/heads/nixpkgs-unstable";
				rev = "d9d87c51960050e89c79e4025082ed965e770d68";
			})
		{
			inherit (pkgs) system;
		}
	);
	nerdfonts = oldPkgs.nerdfonts;
in {
	imports = [
		inputs.stylix.nixosModules.stylix
	];
	environment = {
		systemPackages = [
			nerdfonts
		];
	};
	qt = {
		# workaround https://github.com/nix-community/stylix/issues/1865
		platformTheme = pkgs.lib.mkForce "kde";
	};
	stylix = {
		enable = true;
		image = ../../dotfiles/wallpaper.jpg;
		targets = {
			chromium = {
				enable = false;
			};
		};
		base16Scheme = {
			base00 = "#1A1B26";
			base01 = "#16161E";
			base02 = "#2F3549";
			base03 = "#444B6A";
			base04 = "#787C99";
			base05 = "#A9B1D6";
			base06 = "#CBCCD1";
			base07 = "#D5D6DB";
			base08 = "#C0CAF5";
			base09 = "#A9B1D6";
			base0A = "#0DB9D7";
			base0B = "#9ECE6A";
			base0C = "#B4F9F8";
			base0D = "#2AC3DE";
			base0E = "#BB9AF7";
			base0F = "#F7768E";
		};
		fonts = {
			# emoji = {
			#   package = pkgs.twemoji-color-font;
			#   name = "Twitter Color Emoji";
			# };
			sansSerif = {
				package = nerdfonts;
				name = "ComicShannsMono Nerd Font Mono";
			};
			serif = {
				package = nerdfonts;
				name = "ComicShannsMono Nerd Font Mono";
			};
			monospace = {
				package = nerdfonts;
				name = "ComicShannsMono Nerd Font Mono";
			};
		};
	};
}
