{pkgs, inputs, ...}: 
let
    cpkg = import ../../../customPackages { inherit pkgs inputs; };
in
{
    home = {
        packages = [
            cpkg.frog
        ];
    };
}