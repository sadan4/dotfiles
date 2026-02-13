{
	pkgs,
	config,
	...
}: let
	# use unstable nodejs because of nodejs/node#60580
	node = pkgs.unstable.nodejs_25;
	pnpm = pkgs.unstable.pnpm;
	PNPM_HOME = "/home/${config.home.username}/.local/pnpm-home";
in {
	imports = [
		../prisma.nix
		../../../../customPackages
		../unstable.nix
		./ide/jb/webstorm.nix
	];
	programs = {
		zsh = let
			compgen = name: cmd:
				pkgs.runCommand "${name}-compgen" {} ''
					${cmd} > $out
				'';
		in {
			initContent =
				# sh
				''
					source ${compgen "node" "${node}/bin/node --completion-bash"}
					source ${compgen "npm" "${node}/bin/npm completion"}
					source ${compgen "pnpm" "${pnpm}/bin/pnpm completion zsh"}
					[[ -d ${PNPM_HOME} ]] || mkdir -p ${PNPM_HOME}
				'';
		};
	};
	home = {
		shellAliases = {
			webpack = "webpack-cli";
			eslintd = "eslint_d";
		};
		sessionVariables = {
			inherit PNPM_HOME;
		};
		sessionSearchVariables = {
			PATH = [PNPM_HOME];
		};
		packages = with pkgs;
			[
				(writeShellScriptBin "pd" ''
					exec /home/${config.home.username}/dev/ts/pnpm/pnpm/dev/pd.js "$@"
				'')
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
				unstable.corepack
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
