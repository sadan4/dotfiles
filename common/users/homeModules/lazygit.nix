{pkgs, ...}: {
	imports = [
		./unstable.nix
	];
	home = {
		shellAliases = {
			lg = "lazygit";
		};
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
			};
		};
	};
}
