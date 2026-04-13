{
	pkgs,
	inputs,
	...
}: let
	tf2-rpc = inputs.tf2-rpc.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
	home = {
		packages = with pkgs; [
			tf2-rpc
			xclicker
			(bottles.override {
					removeWarningPopup = true;
				})
			(prismlauncher.override {
					jdks = [
						jdk8
						jdk17
						jdk25
						jdk
					];
				})
			# needed for prism launcher dialogs
			zenity
			protontricks
			lutris
		];
	};
	systemd = {
		user = {
			services = {
				tf2-rpc = {
					Unit = {
						Description = "auto-run tf2 rpc";
						After = ["default.target"];
					};
					Service = {
						Restart = "on-failure";
						ExecStart = "${tf2-rpc}/bin/tf2-rpc";
					};
					Install = {
						WantedBy = ["default.target"];
					};
				};
			};
		};
	};
}
