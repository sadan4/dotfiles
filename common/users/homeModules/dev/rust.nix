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
			# rustup's completion is broken for zsh. See: https://github.com/rust-lang/rustup/issues/2268
			initContent = ''
				eval "$(patch -s -o - -i ${./rustupCompPatch.diff} =(${rustup}/bin/rustup completions zsh))"
			'';
		};
	};
}
