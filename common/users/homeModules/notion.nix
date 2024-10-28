{pkgs, ...}: 
let
    unwrap = (pkgs.writeShellScriptBin "unwrap-notion-uri" ''
        ARGS=$(echo "$*" |  ${pkgs.python3}/bin/python3 -c "import sys; from urllib.parse import unquote;print(unquote(sys.stdin.read()))")
        bottles-cli run -b Notion -e 'C:\windows\system32\cmd.exe' -- "/c %LOCALAPPDATA%/programs/notion/notion.exe \"$ARGS\""

    '');
in
{
  xdg = {
    desktopEntries = {
      notionProtoWrapper = {
        type = "Application";
        name = "Notion-Protocol";
        terminal = false;
        categories = ["Application"];
        exec = "${unwrap}/bin/unwrap-notion-uri %u";
        mimeType = [ "x-scheme-handler/notion" ];
      };
    };
  };
}
