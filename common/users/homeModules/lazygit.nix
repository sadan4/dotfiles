{
  pkgs,
  ...
}:
{
  home = {
    shellAliases = {
      lg = "lazygit";
    };
  };
  stylix = {
    targets = {
      lazygit = {
        enable = false;
      };
    };
  };
  programs = {
    lazygit = {
      enable = true;
      package = pkgs.lazygit.overrideAttrs (
        _: old: {
          src = pkgs.fetchFromGitHub {
            owner = "jesseduffield";
            repo = old.pname;
            rev = "3cff48437e2d831d03be9eda03818368ab7c2a26";
            hash = "sha256-OA40EgUKwNttsoSLi/xtKuEdbK0P5IKiXUGKSOk0gfE=";
          };
        }
      );
      settings = {
        gui = {
          showRootItemInFileTree = false;
          switchTabsWithPanelJumpKeys = true;
          theme = {
            lightTheme = false;
            activeBorderColor = [
              "#ff9e64"
              "bold"
            ];
            inactiveBorderColor = [
              "#27a1b9"
            ];
            searchingActiveBorderColor = [
              "#ff9e64"
              "bold"
            ];
            optionsTextColor = [
              "#7aa2f7"
            ];
            selectedLineBgColor = [
              "#283457"
            ];
            cherryPickedCommitFgColor = [
              "#7aa2f7"
            ];
            cherryPickedCommitBgColor = [
              "#bb9af7"
            ];
            markedBaseCommitFgColor = [
              "#7aa2f7"
            ];
            markedBaseCommitBgColor = [
              "#e0af68"
            ];
            unstagedChangesColor = [
              "#db4b4b"
            ];
            defaultFgColor = [
              "#c0caf5"
            ];
          };
        };
      };
    };
  };
}
