{
	pkgs,
	stable,
	...
}: {
	imports = [
		./unstable.nix
	];
	home = {
		packages = with pkgs; [
			firefox
			vlc
			(unstable.brave.override {
				vulkanSupport = true;
			})
			unstable.ungoogled-chromium
			unstable.microsoft-edge
			unstable.ladybird
		];
	};
}
