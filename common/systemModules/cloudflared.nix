{
	config,
	pkgs,
	...
}: {
	environment = {
		systemPackages = with pkgs; [
			cloudflared
		];
	};
	sops = {
		secrets = {
			cfd = {
				format = "binary";
				sopsFile = ./cloudflared.pem;
			};
			cfdt = {
				format = "binary";
				sopsFile = ./cloudflared.conf;
			};
		};
	};
	boot = {
		kernel = {
			sysctl = {
				"net.core.rmem_max" = 7500000;
				"net.core.wmem_max" = 7500000;
			};
		};
	};
	services = {
		cloudflared = {
			enable = true;
			tunnels = {
				"7bb2884d-fa49-4c9e-893a-81804662582b" = {
					credentialsFile = config.sops.secrets.cfdt.path;
					default = "http_status:404";
					ingress = {
						"jf.sadan.zip" = "http://localhost:80";
					};
				};
			};
			certificateFile = config.sops.secrets.cfd.path;
		};
	};
}
