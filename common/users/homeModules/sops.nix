{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		inputs.sops-nix.homeModules.sops
	];
	sops = {
		age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";
		defaultSopsFile = ../../../secrets.yaml;
		secrets.hosts = {
			format = "binary";
			sopsFile = ../../../secrets/hosts;
			path = "/home/${config.home.username}/.config/gh/hosts.yml";
		};
	};
	home = {
		packages = with pkgs; [
			ssh-to-age
		];
	};
}
