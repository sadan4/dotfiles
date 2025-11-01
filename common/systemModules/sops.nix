{NAME}: {
	config,
	inputs,
	pkgs,
	...
}: {
	imports = [
		inputs.sops-nix.nixosModules.sops
	];
	sops = {
		defaultSopsFile = ../../secrets.yaml;
		defaultSopsFormat = "yaml";
		age = {
			keyFile = "/home/${NAME}/.config/sops/age/keys.txt";
		};
		secrets = {
			password = {
				neededForUsers = true;
			};
			tailscale_server_key = {
			};
		};
	};
	environment = {
		systemPackages = with pkgs; [
			ssh-to-age
		];
	};
	users = {
		users = {
			"${NAME}" = {
				hashedPasswordFile = config.sops.secrets.password.path;
			};
		};
	};
}
