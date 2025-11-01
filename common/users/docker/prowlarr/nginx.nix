{
	services = {
		nginx = {
			virtualHosts = {
				"prowlarr.sadan.zip" = {
					forceSSL = true;
					useACMEHost = "sadan.zip";
					locations = {
						"/" = {
							proxyPass = "http://localhost:9696";
							proxyWebsockets = true;
						};
					};
				};
			};
		};
	};
}
