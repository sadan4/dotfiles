{
	pkgs,
	inputs,
	stable,
	unstable,
	...
}: let
	NAME = "meyer";
in {
	imports = [
		(import ../../systemModules/nixHelper.nix {inherit NAME;})
	];
	users = {
		users = {
			"${NAME}" = {
				isNormalUser = true;
				extraGroups = [
					"wheel" # Enable ‘sudo’ for the user.
					"audio"
					"sound"
					"video"
					"input"
					"tty"
					"plugdev"
				];
				shell = pkgs.zsh;
			};
		};
	};
	home-manager = {
		useUserPackages = true;
		extraSpecialArgs = {inherit inputs stable unstable;};
		users = {
			"${NAME}" = import ./home.nix;
		};
	};
}
