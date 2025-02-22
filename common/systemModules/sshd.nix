{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      kitty.terminfo
    ];
  };
  services = {
    openssh = {
      enable = true;
      authorizedKeysFiles = [ "${./ssh.keys}" ];
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
