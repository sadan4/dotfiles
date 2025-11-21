{pkgs, ...}: let
	graal = pkgs.graalvmPackages.graalvm-ce;
	g = pkgs.gradle.override {
			javaToolchains = [graal];
		};
in {
	imports = [
		./ide/jb/idea.nix
		./ide/jb/androidStudio.nix
	];
	home = {
		sessionVariables = {
			GRAALVM_HOME = "${graal}";
		};
		file = {
			gradleIntellij = {
				source = "${graal}";
				target = ".local/graalvm";
			};
		};
		packages = with pkgs; [
			jadx
			g
			kotlin
		];
	};
	programs = {
		java = {
			enable = true;
			package = pkgs.temurin-bin-21;
		};
	};
}
