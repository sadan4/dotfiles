{NAME}: {...}: {
	virtualisation = {
		docker = {
			enable = true;
		};
	};
	environment = {
		sessionVariables = {
			# DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";
		};
	};
	users = {
		users = {
			"${NAME}" = {
				extraGroups = ["docker"];
			};
		};
	};
}
