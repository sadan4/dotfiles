{ ... }:
{
    services= {
        openssh = {
            enable = true;
            authorizedKeysFiles = ["${./ssh.keys}"];
        };
    };
}
