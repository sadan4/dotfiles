{
	pkgs,
	lib,
	...
}: {
	programs = {
		ssh = {
			askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
		};
		gnupg = {
			agent = {
				pinentryPackage = pkgs.pinentry-gnome3;
			};
		};
		kdeconnect = {
			enable = true;
		};
	};
	# https://github.com/NixOS/nixpkgs/issues/126590#issuecomment-3194531220
	# fix massive lag on KDE plasma caused by $XDG_DATA_DIRS being ~11k chars long
	# this takes it down to ~1.1k
	nixpkgs = {
		overlays =
			lib.singleton
			(final: prev: {
					kdePackages =
						prev.kdePackages
						// {
							plasma-workspace = let
								# the package we want to override
								basePkg = prev.kdePackages.plasma-workspace;

								# a helper package that merges all the XDG_DATA_DIRS into a single directory
								xdgdataPkg =
									pkgs.stdenv.mkDerivation {
										name = "${basePkg.name}-xdgdata";
										buildInputs = [basePkg];
										dontUnpack = true;
										dontFixup = true;
										dontWrapQtApps = true;
										installPhase = ''
											mkdir -p $out/share
											( IFS=:
											  for DIR in $XDG_DATA_DIRS; do
											    if [[ -d "$DIR" ]]; then
											      cp -r $DIR/. $out/share/
											      chmod -R u+w $out/share
											    fi
											  done
											)
										'';
									};

								# undo the XDG_DATA_DIRS injection that is usually done in the qt wrapper
								# script and instead inject the path of the above helper package
								derivedPkg =
									basePkg.overrideAttrs {
										preFixup = ''
											for index in "''${!qtWrapperArgs[@]}"; do
											  if [[ ''${qtWrapperArgs[$((index+0))]} == "--prefix" ]] && [[ ''${qtWrapperArgs[$((index+1))]} == "XDG_DATA_DIRS" ]]; then
											    unset -v "qtWrapperArgs[$((index+0))]"
											    unset -v "qtWrapperArgs[$((index+1))]"
											    unset -v "qtWrapperArgs[$((index+2))]"
											    unset -v "qtWrapperArgs[$((index+3))]"
											  fi
											done
											qtWrapperArgs=("''${qtWrapperArgs[@]}")
											qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "${xdgdataPkg}/share")
											qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "$out/share")
										'';
									};
							in
								derivedPkg;
						};
				});
	};
	services = {
		desktopManager = {
			plasma6 = {
				enable = true;
			};
		};
		displayManager = {
			sddm = {
				wayland = {
					enable = false;
				};
				enable = true;
				autoNumlock = true;
			};
		};
		xserver = {
			enable = true;
		};
	};
}
