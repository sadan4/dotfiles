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
			# qemu is pulled in from virt.nix
			# stable.qemu_full
		];
	};
}
