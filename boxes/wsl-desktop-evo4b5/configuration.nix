{...}: {
	imports = [
		../../common/users/meyer-wsl
		];
	wsl = {
		defaultUser = "meyer";
		enable = true;
	};
	system.stateVersion = "24.05";
	programs.zsh.enable = true;
}
