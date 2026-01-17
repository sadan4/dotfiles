{pkgs, ...}: let
	rustup = pkgs.unstable.rustup;
in {
	imports = [
		../unstable.nix
		./ide/jb/rustRover.nix
	];
	home = {
		packages = with pkgs; [
			perf
			aoc-cli
			rustup
			slint-lsp
			unstable.cargo-watch
			unstable.cargo-expand
			unstable.cargo-insta
			unstable.cargo-flamegraph
			openssl
			# needed to use openssl
			pkg-config
			unstable.dioxus-cli
		];
	};
	programs = {
		zsh = {
			# Few horror things here
			# 1. rustup's completion is broken for zsh. See: https://github.com/rust-lang/rustup/issues/2268
			# 2. patch cant read the source file from stdin, so tmpfiles have to be used
			initContent = ''
				TMP_RUSTUP_FILE=$(mktemp)
				${rustup}/bin/rustup completions zsh > "$TMP_RUSTUP_FILE"
				eval "$(patch -s -o - -i ${./rustupCompPatch.diff} $TMP_RUSTUP_FILE)"
				rm $TMP_RUSTUP_FILE
				unset TMP_RUSTUP_FILE
			'';
		};
	};
}
