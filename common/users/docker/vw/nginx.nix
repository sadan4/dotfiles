{...}: {
	services = {
		nginx = {
			virtualHosts = {
				"vw.sadan.zip" = {
					forceSSL = true;
					useACMEHost = "sadan.zip";
					locations = {
						"/" = {
							proxyPass = "http://localhost:3231";
						};
					};
				};
			};
		};
	};
}
