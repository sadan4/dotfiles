{pkgs, ...}: let
	rustup = pkgs.unstable.rustup;
in {
	imports = [
		../unstable.nix
		./ide/jb/rustRover.nix
		../perf.nix
	];
	home = {
		packages = with pkgs; [
			aoc-cli
			rustup
			slint-lsp
			unstable.cargo-watch
			unstable.cargo-expand
			unstable.cargo-insta
			unstable.cargo-nextest
			unstable.cargo-shear
			(unstable.cargo-flamegraph.override {inherit perf;})
			openssl
			# needed to use openssl
			pkg-config
		];
	};
	programs = {
		zsh = {
			# rustup's completion is broken for zsh. See: https://github.com/rust-lang/rustup/issues/2268
			initContent = ''
				source ${
					pkgs.runCommand "rustup-compgen" {} ''
						TMP_RUSTUP_FILE=$(mktemp)
						# rustup will attempt to create ~/.rustup, which will fail as we don't have a home dir
						HOME=$(mktemp -d) ${rustup}/bin/rustup completions zsh > "$TMP_RUSTUP_FILE"
						patch -s -o $out -i ${./rustupCompPatch.diff} $TMP_RUSTUP_FILE
					''
				}
			'';
		};
	};
}
