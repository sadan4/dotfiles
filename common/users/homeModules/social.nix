{
	pkgs,
	inputs,
	config,
	...
}: {
	imports = [
		./arrpc.nix
		# inputs.nixcord.homeManagerModules.nixcord
		./unstable.nix
	];
	# programs.nixcord = {
	#   enable = false;
	#   discord = {
	#     enable = true;
	#     vencord = {
	#       enable = true;
	#       unstable = true;
	#     };
	#   };
	# };
	home = {
		packages = with pkgs; [
			legcord
			element-desktop
			signal-desktop
			unstable.vesktop
			(discord.override {
					#   withVencord = true;
					#   vencord = unstable.vencord;
				})
			# (config.programs.nixcord.discord.package.override {
			#   withVencord = true;
			#   # vencord = config.programs.nixcord.discord.vencord.package;
			# })
		];
	};
}
