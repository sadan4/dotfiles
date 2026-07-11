{
	pkgs,
	inputs,
	...
}: {
	imports = [
		../unstable.nix
		./ide/jb/clion.nix
		../pinned.nix
		../perf.nix
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
			conan
			gdb
			lldb
			lld
			cpkg.ceserver
			clang-tools
			# for llvm-symbolizer
			llvmPackages.libllvm
			inputs.nix-cppman.packages.${pkgs.stdenv.hostPlatform.system}.default
			# perf GUI
			hotspot
		];
		file = {
			eslint_d_config = {
				source = ../../../../dotfiles/eslintrc.json;
				target = "./.config/.eslintrc.json";
			};
			gdb_config = {
				source =
					pkgs.replaceVars ../../../../dotfiles/gdb/gdbinit {
						libgcc = pkgs.libgcc.lib;
						libgccVersion = pkgs.libgcc.lib.version;
					};
				target = "./.config/gdb/gdbinit";
				recursive = true;
			};
		};
	};
}
