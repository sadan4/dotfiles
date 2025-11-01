{
	nixpkgs,
	pkgs,
	...
}: {
	nixpkgs.overlays = [
		(final: prev: {
				vscode-insider = (
					(prev.vscode.override {
							isInsiders = true;
						}).overrideAttrs
					(
						_: old: let
							sourceExecutableName = "code-insiders";
							executableName = "code-insiders";
						in {
							pname = "code-insiders";
							installPhase = ''
								runHook preInstall
								mkdir -p "$out/lib/vscode" "$out/bin"
								cp -r ./* "$out/lib/vscode"

								mv "$out/lib/vscode/bin/code" "$out/lib/vscode/bin/${sourceExecutableName}" # ME
								mv "$out/lib/vscode/code" "$out/lib/vscode/${sourceExecutableName}" # ME

								ln -s "$out/lib/vscode/bin/${sourceExecutableName}" "$out/bin/${executableName}"

								mkdir -p "$out/share/applications"
								ln -s "$desktopItem/share/applications/${executableName}.desktop" "$out/share/applications/${executableName}.desktop"
								ln -s "$urlHandlerDesktopItem/share/applications/${executableName}-url-handler.desktop" "$out/share/applications/${executableName}-url-handler.desktop"

								# These are named vscode.png, vscode-insiders.png, etc to match the name in upstream *.deb packages.
								mkdir -p "$out/share/pixmaps"
								cp "$out/lib/vscode/resources/app/resources/linux/code.png" "$out/share/pixmaps/vs${executableName}.png"

								# Override the previously determined VSCODE_PATH with the one we know to be correct
								sed -i "/ELECTRON=/iVSCODE_PATH='$out/lib/vscode'" "$out/bin/${executableName}"
								grep -q "VSCODE_PATH='$out/lib/vscode'" "$out/bin/${executableName}" # check if sed succeeded

								# Remove native encryption code, as it derives the key from the executable path which does not work for us.
								# The credentials should be stored in a secure keychain already, so the benefit of this is questionable
								# in the first place.
								rm -rf $out/lib/vscode/resources/app/node_modules/vscode-encrypt
								# HOOK
								runHook postInstall
							'';

							postFixup = ''
								  patchelf \
								--add-needed ${pkgs.libglvnd}/lib/libGLESv2.so.2 \
								--add-needed ${pkgs.libglvnd}/lib/libGL.so.1 \
								--add-needed ${pkgs.libglvnd}/lib/libEGL.so.1 \
								$out/lib/vscode/${sourceExecutableName}
							'';
							meta =
								old.meta
								// {
									mainProgram = "code-insiders";
								};
						}
					)
				);
			})
	];
}
