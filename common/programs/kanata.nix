{ NAME }:
{ pkgs, ... }:
{
  # services = {
  #   kanata = {
  #     enable = true;
  #     keyboards = {
  #       razer = {
  #         # devices = [
  #         #   "/dev/input/by-id/usb-Razer_Razer_BlackWidow_V4-event-kbd"
  #         # ];
  #         extraDefCfg = "process-unmapped-keys yes";
  #         config = ''
  #           (defsrc
  #           caps
  #           )
  #           (defvar
  #           tap-time 150
  #           hold-time 200
  #           )
  #           (defalias
  #           caps (tap-hold 100 100 esc lctrl)
  #           )
  #           (deflayer base
  #               @caps
  #           )
  #
  #         '';
  #       };
  #     };
  #   };
  # };
  users = {
    users = {
      "${NAME}" = {
        extraGroups = [
          "uinput"
        ];
      };
    };
  };
  systemd.services.kanata-meyer = {
    enable = true;
    description = "services-kanata sucks ass";
    serviceConfig = {
      ExecStart = ''
        ${pkgs.kanata}/bin/kanata \
        --cfg ${./config.kbd}
      '';
      User=NAME;
    };
    wantedBy = [ "multi-user.target" ];
  };
}
