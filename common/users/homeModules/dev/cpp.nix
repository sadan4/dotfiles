{
	pkgs,
	inputs,
	...
}: {
	imports = [
		../unstable.nix
		./ide/jb/clion.nix
		../pinned.nix
	];
	home = {
		packages = with pkgs; [
			xorg.libX11.man
			meson
			autoPatchelfHook
			cmake
			ninja
			# clang
			libgcc
			# provides a python module that i use in my gdbinit
			libgcc.lib
			glib
			gdbgui
			bear
			glibc
			pinned.gdb
			lldb_19
			cpkg.ceserver
			# https://github.com/NixOS/nixpkgs/issues/463367
			pinned.clang-tools
			inputs.nix-cppman.packages.${pkgs.system}.default
		];
		file = {
			eslint_d_config = {
				source = ../../../../dotfiles/eslintrc.json;
				target = "./.config/.eslintrc.json";
			};
			gdb_config = {
				source = pkgs.replaceVars ../../../../dotfiles/gdb/gdbinit {
					libgcc = pkgs.libgcc.lib;
					libgccVersion = pkgs.libgcc.lib.version;
				};
				target = "./.config/gdb/gdbinit";
				recursive = true;
			};
		};
	};
}
