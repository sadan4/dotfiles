{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  # cpkg = import ../../../../customPackages { inherit pkgs inputs; };
  # https://discourse.nixos.org/t/how-to-create-a-script-with-dependencies/7970/6
  mkScript =
    {
      name,
      version ? "0.0.1",
      file,
      env ? [ ],
    }:
    pkgs.writeTextFile {
      name = "${name}-${version}";
      executable = true;
      destination = "/bin/${name}";
      text = ''
        export PATH=""
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
        env = with pkgs; [
          git
        ];
      })
      (mkScript {
        name = "git_fetchAll";
        file = ./git_fetchAll.sh;
        env = with pkgs; [
          git
        ];
      })
      (mkScript {
        name = "install_eslint";
        file = ./install_eslint.sh;
      })
      (mkScript {
        name = "math";
        file = ./math.sh;
        env = with pkgs; [
          python3
        ];
      })
      (mkScript {
        name = "hashi18n";
        file = ./hashi18n.sh;
      })
      (mkScript {
        name = "flakeify";
        file = ./flakeify.sh;
        env = with pkgs; [
          direnv
        ];
      })
      (mkScript {
        name = "detach";
        file = ./detach.sh;
        env = with pkgs; [
          coreutils
        ];
      })
      # impl for the cloneRepo command
    ];
    file = {
      scripts = {
        source = "${pkgs.cpkg.scripts}";
        target = ".scripts";
      };
    };
    shellAliases = {
      paste = "${
        (mkScript {
          name = "paste";
          file = ./paste.sh;
        })
      }/bin/paste";
      p = "${builtins.readFile ./projectPicker.sh}";
    };
  };
  programs = {
    zsh = {
      initExtra =
        let
          implName = "cloneRepoImpl";
        in
        ''
          cloneRepo() {
              local dir;
              dir=$(${
                (mkScript {
                  name = implName;
                  file = ./cloneRepoImpl.sh;
                  env = with pkgs; [
                    gh
                    fzf
                  ];
                })
              }/bin/${implName})
              if [[ $? -eq 0 ]]; then
                  cd ''${dir}
              fi
          }
        '';
    };
  };
}
