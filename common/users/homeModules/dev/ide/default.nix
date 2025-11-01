{
	pkgs,
	config,
	...
}: let
in {
	imports = [
		../../pinned.nix
		../../unstable.nix
	];
	home = {
		packages = with pkgs; [
			unstable.vscode
			# codium
			zed-editor
		];
		shellAliases = {
			codetemp = "code -n $(mktemp -d)";
		};
		file = {
			vscode_neovim = {
				source = "${pkgs.pinned.vscode_neovim}/bin/nvim";
				target = ".bin/vscode-neovim";
			};
		};
		sessionPath = ["$HOME/.bin"];
	};
}
