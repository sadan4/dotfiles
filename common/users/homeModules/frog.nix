{ pkgs, inputs, ... }:
{
  imports = [
    ../../../customPackages
  ];
  home = {
    packages = with pkgs.cpkg; [
      frog
    ];
  };
  programs = {
    plasma = {
      hotkeys = {
        commands = {
          "ocr" = {
            name = "OCR";
            key = "Meta+Shift+T";
            command = "frog -e";
          };
        };
      };
    };
  };
}
