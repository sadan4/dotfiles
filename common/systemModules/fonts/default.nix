{ pkgs, lib, ... }:

let

  mergeDefaults = (
    fontPathOrObj:
    if builtins.typeOf fontPathOrObj == "path" then
      mergeDefaults { src = fontPathOrObj; }
    else if builtins.typeOf fontPathOrObj == "set" then
      rec {
        name =
          if builtins.hasAttr "name" fontPathOrObj then
            fontPathOrObj.name
          else
            head (builtins.split "." (tail (builtins.split "/" (pathToStr fontPathOrObj.src))));
        description = "A font ${name}";
      }
      // fontPathOrObj
    else
      throw "Unknown type ${builtins.typeOf fontPathOrObj}, expected either a path or a set"
  );

  head = list: builtins.elemAt list 0;
  tail = list: builtins.elemAt list (builtins.length list - 1);

  pathToStr = (path: "${path}");

  listToStr = (list: "[ ${lib.strings.concatStrings (lib.strings.intersperse ", " list)} ]");

  mkFontInstaller =
    type:
    {
      name,
      src,
      description,
    }:
    pkgs.stdenvNoCC.mkDerivation {
      inherit src name;
      meta = {
        inherit description;
      };
      dontUnpack = true;
      dontConfigure = true;
      installPhase = ''
        mkdir -p $out/share/fonts
        cp -R $src $out/share/fonts/${type}
      '';
    };

  fontFormatMap = {
    "otf" = mkFontInstaller "opentype";
    "ttf" = mkFontInstaller "truetype";
    "error" =
      { src, ... }:
      throw "Invalid Font extension, got ${src}, while only ${
        listToStr (builtins.filter (key: key != "error") (builtins.attrNames fontFormatMap))
      } are supported";
  };

  getFontInstaller =
    fontObj:
    (
      fontPath:
      fontFormatMap."${(fontExt: if builtins.hasAttr fontExt fontFormatMap then fontExt else "error") (
        tail (builtins.split "\\." (pathToStr fontPath))
      )}"
    )
      fontObj.src;

  mkFontPackages =
    fontPathOrObj: (fontAsObj: getFontInstaller fontAsObj fontAsObj) (mergeDefaults fontPathOrObj);
in
{
  environment = {
    # I love typescript
    # Path | (({ name?: string; src: Path; } | { name: string; src: Derivation; }) & { description?: string; })
    systemPackages = lib.map mkFontPackages [
      ./futura.otf
    ];
  };
  fonts = {
    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
  };
}
