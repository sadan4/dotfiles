{pkgs, ...}: {
	imports = [
		../pinned.nix
		../lazygit.nix
	];
	home = {
		packages = with pkgs; [
			git
			act
			gh
		];
		file = {
			ghcli = {
				source = ../../../../dotfiles/gh/config.yml;
				target = "./.config/gh/config.yml";
			};
		};
	};
	programs = {
		git = {
			enable = true;
			lfs = {
				enable = true;
			};
			settings = {
				user = {
					name = "sadan";
					email = "117494111+sadan4@users.noreply.github.com";
				};
				gpg = {
					format = "ssh";
				};
				user = {
					signingkey = "~/.ssh/id_ed25519";
				};
				commit = {
					gpgsign = true;
				};
				core = {
					autocrlf = "input";
				};
				pull = {
					rebase = true;
				};
				push = {
					autoSetupRemote = true;
				};
				init = {
					defaultBranch = "main";
				};
				rerere = {
					enabled = true;
				};
			};
		};
	};
}
