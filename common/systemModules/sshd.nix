{ ... }:
{
    services= {
        openssh = {
            authorizedKeysFiles = ["${./ssh.keys}"];
        };
    };
}
