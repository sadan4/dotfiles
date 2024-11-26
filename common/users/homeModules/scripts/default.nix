{pkgs, lib, inputs, ...}: 
let 
cpkg = import ../../../customPackages { inherit pkgs inputs; };
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

        exec ${bash}/bin/bash ${file} $@
      '';
    };
in 
{
    home = {
        packages = with pkgs; [
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
                env = [git];
            })
            (mkScript {
                name = "git_fetchAll";
                file = ./git_fetchAll.sh;
                env = [git];
            })
            (mkScript {
                name = "install_eslint";
                file = ./install_eslint.sh;
            })
            (mkScript {
                name = "math";
                file = ./math.sh;
                env = [python3];
            })
            (mkScript {
                name = "hashi18n";
                file = ./hashi18n.sh;
            })
        ];
        file = {
            scripts = {
                source = "${cpkg.scripts}";
                target = ".scripts";
            };
        };
    };
}