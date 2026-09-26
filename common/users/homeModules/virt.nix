{pkgs, ...}: {
	imports = [
		./stable.nix
	];
	home = {
		packages = with pkgs; [
			(bottles.override {
					removeWarningPopup = true;
				})
			stable.virt-manager
			stable.qemu_full
		];
	};
}
