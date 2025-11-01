{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
	nativeBuildInputs = with pkgs; [
		alejandra
		bash
		sops
		ssh-to-age
		git
		openssh
		neovim
		nano
		wget
		curl
	];
}
