{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            p7zip
            dig
            bat
            usbutils
            tree
            sops
            fzf
            jq
            unzip
        ];
        sessionVariables = {
            BAT_THEME = "Dracula";
            SSH_ASKPASS_REQUIRE = "prefer";
        };
        sessionPath = [
        "$HOME/.local/bin"
        ];
    };
}