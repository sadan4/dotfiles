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
    let
      text = ''
        export PATH="${lib.makeSearchPath "bin" env}";

        exec ${pkgs.bash}/bin/bash ${file} $@
      '';
    in
    pkgs.writeTextFile {
      name = "${name}-${version}";
      executable = true;
      destination = "/bin/${name}";
      inherit text;
    };
  paste = mkScript {
    name = "paste";
    file = ./paste.sh;
    env = with pkgs; [
      coreutils
      xsel
    ];
  };
  copy = mkScript {
    name = "copy";
    file = ./copy.sh;
    env = with pkgs; [
      xsel
    ];
  };
in
{
  imports = [
    ../../../../customPackages
  ];
  home = {
    packages = [
      paste
      copy
      # env for clipboard command will be required by their respective environemnts
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
      # needed because of coreutils paste
      paste = "${paste}/bin/paste";
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
