{NAME}: {...}: {
	programs = {
		wireshark = {
			enable = true;
		};
	};
	boot = {
		kernelModules = [
			"usbmon"
		];
	};
	services = {
		udev = {
			extraRules = ''
				SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="640"
			'';
		};
	};
	users = {
		users = {
			"${NAME}" = {
				extraGroups = [
					"wireshark"
				];
			};
		};
	};
}
