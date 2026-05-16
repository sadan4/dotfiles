{
	pkgs,
	inputs,
	...
}: let
	tf2-rpc = inputs.tf2-rpc.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
	nixpkgs = {
		overlays = [
			(self: super: {
					# Workaround: openldap 2.6.13 test017-syncreplication-refresh is flaky in the
					# Nix sandbox and fails on x86_64-linux, breaking anything depending on wine
					# (e.g. bottles, lutris).
					# Upstream issues:
					#   - openldap: test checks won't let it compile on x86_64
					#     https://github.com/NixOS/nixpkgs/issues/514113
					#   - Build failure: lutris-free
					#     https://github.com/NixOS/nixpkgs/issues/513245
					# TODO: Remove once upstream disables the flaky test or releases a fix.
					openldap =
						super.openldap.overrideAttrs (old: {
								doCheck = false;
							});
				})
		];
	};
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
