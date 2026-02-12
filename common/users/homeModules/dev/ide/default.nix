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
			(unstable.vscode.overrideAttrs (final: _: {
				version = "1.109.2";
				src = pkgs.fetchurl {
					name = "VSCode_1.109.2_linux-x64.tar.gz";
					url = "https://update.code.visualstudio.com/1.109.2/linux-x64/stable";
					hash = "sha256-ST5i8gvNtAaBbmcpcg9GJipr8e5d0A0qbdG1P9QViek=";
				};
			}))
			# codium
			unstable.zed-editor
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
