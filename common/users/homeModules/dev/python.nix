{pkgs, ...}: {
	home = {
		packages = with pkgs; [
			(python312.withPackages (
					ps:
						with ps; [
							pytesseract
							pillow
							pyzbar
							pygobject3
							nanoid
							loguru
							evdev
							setuptools
							protobuf
							psutil
						]
				))
			python312Packages.openai-whisper
		];
	};
}
