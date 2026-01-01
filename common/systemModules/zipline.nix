{
	config,
	lib,
	...
}: {
	users = {
		groups = {
			zipline = {};
		};
		users = {
			zipline = {
				isSystemUser = true;
				group = config.users.groups.zipline.name;
			};
		};
	};
	# incompitable with sops users
	systemd.services.zipline.serviceConfig.DynamicUser = lib.mkForce false;
	systemd.services.zipline.serviceConfig.User =
		lib.mkForce config.users.users.zipline.name;
	systemd.services.zipline.serviceConfig.Group =
		lib.mkForce config.users.groups.zipline.name;
	sops = {
		secrets = {
			zipline = {
				# plaintext, but same difference
				format = "binary";
				sopsFile = ./ziplineSecret.txt;
				restartUnits = ["zipline.service"];
				owner = "zipline";
				group = "zipline";
			};
		};
	};
	services = {
		zipline = {
			enable = true;
			settings = {
				DATASOURCE_TYPE = "local";
				DATASOURCE_LOCAL_DIRECTORY = "${config.fileSystems."/storage".mountPoint}/zipline";
				CORE_HOSTNAME = "0.0.0.0";
				CORE_PORT = 6767;
				CORE_SECRET_FILE = config.sops.secrets.zipline.path;
			};
		};
		nginx = {
			virtualHosts = {
				"host.sadan.zip" = {
					forceSSL = true;
					useACMEHost = "sadan.zip";
					locations = {
						"/" = {
							proxyPass = "http://localhost:6767";
							proxyWebsockets = true;
						};
					};
				};
			};
		};
	};
}
