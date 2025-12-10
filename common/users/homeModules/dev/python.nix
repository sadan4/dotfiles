{
	pkgs,
	lib,
	config,
	...
}: {
	options.sadan.pythonPackages =
		lib.mkOption {
			type = lib.types.listOf lib.types.package;
		};
	config = {
		home = {
			packages = with pkgs; [
				(python312.withPackages (_: config.sadan.pythonPackages))
			];
		};
		sadan = {
			pythonPackages = with pkgs.python312Packages; [
				# pytesseract
				# pillow
				# pyzbar
				# pygobject3
				# nanoid
				# loguru
				# evdev
				# setuptools
				# protobuf
				# psutil
				# openai-whisper
			];
		};
	};
}
