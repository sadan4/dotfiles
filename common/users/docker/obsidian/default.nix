{config, ...}: {
	imports = [
		../../homeModules/sops.nix
	];
	home = {
		file = {
			couchdb_compose = {
				source = ./docker-compose.yaml;
				target = "./src/obsidian/docker-compose.yaml";
			};
		};
	};
	systemd = {
		user = {
			tmpfiles = {
				rules = [
					"C /home/${config.home.username}/src/obsidian/Dockerfile 0444 - - 0 ${./Dockerfile}"
					"C /home/${config.home.username}/src/obsidian/docker-entrypoint.sh 0555 - - 0 ${./docker-entrypoint.sh}"
					"C /home/${config.home.username}/src/obsidian/10-docker-default.ini 0444 - - 0 ${./10-docker-default.ini}"
					"C /home/${config.home.username}/src/obsidian/vm.args 0444 - - 0 ${./vm.args}"
					"C /home/${config.home.username}/src/obsidian/docker.ini 0444 - - 0 ${config.sops.secrets.couchdb_docker-ini.path}"
					"C /home/${config.home.username}/src/obsidian/couchdb.env 0444 - - 0 ${config.sops.secrets.couchdb_env.path}"
				];
			};
		};
	};
	sops = {
		secrets = {
			couchdb_env = {
				format = "dotenv";
				sopsFile = ./couchdb.env;
			};
			# encrypted because it has a hashed password
			couchdb_docker-ini = {
				format = "ini";
				sopsFile = ./docker.ini;
			};
		};
	};
}
