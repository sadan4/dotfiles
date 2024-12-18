{pkgs, lib, inputs, ...}: 
let 
# cpkg = import ../../../../customPackages { inherit pkgs inputs; };
# https://discourse.nixos.org/t/how-to-create-a-script-with-dependencies/7970/6
mkScript = { name, version ? "0.0.1", file, env ? [ ] }:
    pkgs.writeTextFile {
      name = "${name}-${version}";
      executable = true;
      destination = "/bin/${name}";
      text = ''
        for i in ${lib.concatStringsSep " " env}; do
          export PATH="$i/bin:$PATH"
        done

        exec ${pkgs.bash}/bin/bash ${file} $@
      '';
    };
in 
{
    imports = [
        ../../../../customPackages
    ];
    home = {
        packages = [
            # env for clipboard command will be required by their respective environemnts
            (mkScript {
                name = "paste";
                file = ./paste.sh;
            })
            (mkScript {
                name = "copy";
                file = ./copy.sh;
            })
            (mkScript {
                name = "http2ssh";
                file = ./http2ssh.sh;
                env = [pkgs.git];
            })
            (mkScript {
                name = "git_fetchAll";
                file = ./git_fetchAll.sh;
                env = [pkgs.git];
            })
            (mkScript {
                name = "install_eslint";
                file = ./install_eslint.sh;
            })
            (mkScript {
                name = "math";
                file = ./math.sh;
                env = [pkgs.python3];
            })
            (mkScript {
                name = "hashi18n";
                file = ./hashi18n.sh;
            })
            (mkScript {
                name = "flakeify";
                file = ./flakeify.sh;
                deps = [pkgs.direnv];
            })
        ];
        file = {
            scripts = {
                source = "${pkgs.cpkg.scripts}";
                target = ".scripts";
            };
        };
    };
}
