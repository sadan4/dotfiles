{pkgs, ...}: {
	imports = [
		../../../../customPackages
	];
	home = {
		packages = with pkgs; [
			# for rpmbuild
			swift
			rpm
			cpkg.appimagetool
			appstream
		];
	};
}
