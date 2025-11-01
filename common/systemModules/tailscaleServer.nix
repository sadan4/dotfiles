{config, ...}: {
	services = {
		tailscale = {
			enable = true;
			authKeyFile = config.sops.secrets.tailscale_server_key.path;
			extraSetFlags = ["--advertise-exit-node=true"];
		};
	};
}
