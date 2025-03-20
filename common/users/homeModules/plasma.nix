{ inputs, ... }:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    # TODO: import dynamically based on hostname
    ./displays/nix-desktop-evo4b5.nix
  ];
  programs = {
    plasma = {
      enable = true;
      hotkeys = {
        commands = {
          "ocr" = {
            name = "OCR";
            key = "Meta+Shift+T";
            command = "frog -e";
          };
          "flameshot" = {
            name = "flameshot";
            key = "Print";
            command = "flameshot gui";
          };
          "rofi" = {
            name = "rofi";
            key = "Alt+P";
            command = "rofi -show drun";
          };
          "kitty" = {
            name = "kitty";
            key = "Alt+Shift+Return";
            command = "kitty";
          };
        };
      };
    };
  };
}
