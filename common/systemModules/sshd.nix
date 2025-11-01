{pkgs, ...}: {
	environment = {
		systemPackages = with pkgs; [
			kitty.terminfo
		];
		etc = {
			"all_users_authorized_keys" = {
				source = ./ssh.keys;
				mode = "0644";
				uid = 0;
				gid = 0;
			};
		};
	};
	services = {
		openssh = {
			enable = true;
			authorizedKeysFiles = ["/etc/all_users_authorized_keys"];
			settings = {
				PasswordAuthentication = false;
			};
		};
	};
}
