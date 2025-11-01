# SETUP GUIDE HERE https://github.com/ShareX/ShareX/issues/6531
{pkgs, ...}: {
	home = {
		packages = with pkgs; [
			wine
			winetricks
		];
	};
}
