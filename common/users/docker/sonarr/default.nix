{pkgs, ...}: 
let 
	sqlite = pkgs.callPackage ../../../../customPackages/sqlite {};
	sonarr = pkgs.sonarr.override { inherit sqlite; };
in{
	imports = [
		./nginx.nix
	];
	services = {
		sonarr = {
			package = sonarr;
			enable = true;
			group = "media";
			dataDir = "/storage/sonarrConf";
		};
	};
}
