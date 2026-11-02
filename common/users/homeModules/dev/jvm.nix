{pkgs, ...}: 
{
	imports = [
		./ide/jb/idea.nix
		./ide/jb/androidStudio.nix
	];
	home = {
		packages = with pkgs; [
			jadx
			gradle
			kotlin
			bazel_8
		];
	};
	programs = {
		java = {
			enable = true;
			package = pkgs.temurin-bin-21;
		};
	};
}
