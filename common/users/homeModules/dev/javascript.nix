{pkgs, ...}: let
	# use unstable nodejs because of nodejs/node#60580
	node = pkgs.unstable.nodejs_25;
in {
	imports = [
		../prisma.nix
		../../../../customPackages
		../unstable.nix
		./ide/jb/webstorm.nix
	];
	programs = {
		zsh = {
			initContent = ''
				eval "$(${node}/bin/node --completion-bash)"
				eval "$(${node}/bin/npm completion)"
				eval "$(${pkgs.pnpm}/bin/pnpm completion zsh)"
			'';
		};
	};
	home = {
		shellAliases = {
			pd = "/home/meyer/dev/ts/pnpm/pnpm/dev/pd.js";
			webpack = "webpack-cli";
			eslintd = "eslint_d";
		};
		packages = with pkgs;
			[
				cpkg.chrome-pak-customizer
				lemminx
				deno
				bun
				eslint_d
				vscode-langservers-extracted
				nodePackages_latest.typescript-language-server
				electron-fiddle
				typescript
				unstable.eslint
				unstable.corepack_24
				node
				vsce
				esbuild
				swc
				terser
				asar
				# read electron crash dumps
				breakpad
				emscripten
			]
			++ (with pkgs.nodePackages; [
					webpack-cli
					nodemon
				]);
	};
}
