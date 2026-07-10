{pkgs, ...}: {
	imports = [
		./unstable.nix
	];
	home = {
		packages = with pkgs; [
			firefox
			vlc
			(unstable.brave.override {
					commandLineArgs = "--ignore-gpu-blocklist";
				})
			unstable.ungoogled-chromium
			unstable.microsoft-edge
			unstable.ladybird
		];
	};
}
