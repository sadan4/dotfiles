{pkgs, ...}: {
	imports = [
		../../pinned.nix
		../../unstable.nix
		../python.nix
	];
	sadan = {
		pythonPackages = with pkgs.python312Packages; [
			# for previewing rst inside of vscode
			docutils
			# codeblocks in rst
			pygments
		];
	};
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
