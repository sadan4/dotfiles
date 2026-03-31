{pkgs, ...}: let
	tig = pkgs.tig;
in {
	imports = [
		./unstable.nix
	];
	home = {
		shellAliases = {
			lg = "lazygit";
		};
		packages = [
			tig
		];
	};
	stylix = {
		targets = {
			lazygit = {
				enable = false;
			};
		};
	};
	programs = {
		lazygit = {
			enable = true;
			package = pkgs.unstable.lazygit;
			settings = {
				notARepository = "quit";
				promptToReturnFromSubprocess = false;
				git = {
					localBranchSortOrder = "recency";
				};
				gui = {
					showRootItemInFileTree = false;
					switchTabsWithPanelJumpKeys = true;
					theme = {
						lightTheme = false;
						activeBorderColor = [
							"#ff9e64"
							"bold"
						];
						inactiveBorderColor = [
							"#27a1b9"
						];
						searchingActiveBorderColor = [
							"#ff9e64"
							"bold"
						];
						optionsTextColor = [
							"#7aa2f7"
						];
						selectedLineBgColor = [
							"#283457"
						];
						cherryPickedCommitFgColor = [
							"#7aa2f7"
						];
						cherryPickedCommitBgColor = [
							"#bb9af7"
						];
						markedBaseCommitFgColor = [
							"#7aa2f7"
						];
						markedBaseCommitBgColor = [
							"#e0af68"
						];
						unstagedChangesColor = [
							"#db4b4b"
						];
						defaultFgColor = [
							"#c0caf5"
						];
					};
				};
				customCommands = [
					{
						key = "b";
						command = "${tig}/bin/tig blame -- {{.SelectedFile.Name}}";
						context = "files";
						description = "blame file at tree";
						output = "terminal";
					}
					{
						key = "b";
						command = "${tig}/bin/tig blame {{.SelectedSubCommit.Sha}} -- {{.SelectedCommitFile.Name}}";
						context = "commitFiles";
						description = "blame file at revision";
						output = "terminal";
					}
					{
						key = "B";
						command = "${tig}/bin/tig blame -- {{.SelectedCommitFile.Name}}";
						context = "commitFiles";
						description = "blame file at tree";
						output = "terminal";
					}
				];
			};
		};
	};
}
