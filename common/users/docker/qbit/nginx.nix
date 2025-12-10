{
	services = {
		nginx = {
			virtualHosts = {
				"qbit.sadan.zip" = {
					forceSSL = true;
					useACMEHost = "sadan.zip";
					locations = {
						"/" = {
							proxyPass = "http://localhost:3456";
							proxyWebsockets = true;
						};
					};
				};
			};
		};
	};
}
