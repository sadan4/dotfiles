# My Dotfiles

> [!NOTE]  
> I am relatively new to nix and a lot of the things i do are bad practice, if you think something should be done a better way, feel free to open an issue or pr

> [!NOTE]  
> The code from this repo is MIT, but if it helped you in any way, please credit and/or leave a star

# Notes
The most important tidbits about my config

## Stable vs. Unstable nixpkgs
This repo uses both stable and unstable nix at the same time, in all configurations, in a way where any given configuration can use either stable or unstable as the default

This is done by adding the arguments stable and unstable as special args

> [!IMPORTANT]  
> Remember to pass stable and unstable to home manager as `extraSpecialArgs` along with the rest of your args (`inputs`, `pkgs`, ...)

```nix
nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
              unstable = import nixpkgs-unstable {
                inherit system;
                config = {
                  allowUnfree = true;
                };
              };
            };
            modules = [
              (
                { pkgs, ... }:
                {
                  _module.args = {
                    stable = pkgs;
                  };
                }
              )
              ./boxes/serverpc/configuration.nix
              inputs.home-manager.nixosModules.default # home-manager-unstable also exists for unstable systems, make sure to match
            ];
          };
```
they are then used to install packages from the respective channels

In home manager, instead of using unstable directly, unstable is  overlayed onto packages, and any module using unstable packages **MUST** import /common/users/homeModules/unstable.nix

stable will be done using a similar overlay soon


## Pinned Packages
i have various packages pinned for different reasons (unfixed regressions, old software, breaking configuration changes, etc...)

All pinned packages are declared in /common/users/homeModules/pinned.nix, as overlays under a pinned prop, eg: to access the pinned package `foo` you would write `pkgs.pinned.foo`

Any module using a pinned package **MUST** import /common/users/homeModules/pinned.nix

To generate the code for a pinned package (commit hash, SRI, etc...) use [nix-versions](https://lazamar.co.uk/nix-versions/) 

Its open source too! [Check it out](https://github.com/lazamar/nix-package-versions) and give it a star.


## Overlays in Home Manager
Any package that uses an overlay should itself be a folder with a `./default.nix` file and import `./overlays.nix`

## Graphical and Command line packages
To make modules more reusable, if a module imports both graphical and command line tools, it should itself be a folder with `./default.nix` importing `./cli.nix` and `./gui.nix`

`./cli.nix` and `./gui.nix` should export the needed CLI and graphical tools, respectively

## Secret Managment
[sops.nix](https://github.com/Mic92/sops-nix) is used for secret management

see `/.sops.yaml` and both `sops.nix` modules for more info

home modules that use sops **MUST** import `/common/users/homeModules/sops.nix`

---

# Layout

this repo is a bit insane with how things are laid out

## /boxes/\<system>/
has `./configuration.nix` and `./hardware-configuration.nix` as well as any other non-shared modules that are needed for said system

## /common/
really a src dir

### /common/programs/\<program>.nix
contains programs used used by the system and shared across systems
### /common/systemModules/\<module>.nix
contains modules used by the system, eg ssh, nginx, audio, kernel
# /common/users
This is where most of the code is
## /common/users/docker/\<service>
the full configuration needed to setup and run a docker service, could include sops secrets, docker/docker compose files, and configuration files in clear text
make sure to enable linger on the user thats running them
### /common/users/docker/\<service>/default.nix
a home manager module that installs this service to `~/src/<service>/`
> [!NOTE]  
> I currently use a mix of `home.file`, `sops.secrets.<secret>.path` and `systemd.user.tmpfiles.rules` to manage needed files, if anyway knows a better way to move away from systed tmpfiles, please reach out and let me know
### /common/users/docker/\<service>/nginx.nix
an system module, **not a home manager module**

setus up any nginx config needed for the service as well as any other needed system configuration that cant be done with home manager
> [!WARNING]
> This will not enable nginx or setup ssl certs, to do that, see /common/systemModules/nginx.nix

## /common/users/homeModules/
contains all the modules for my configuration **most of the important code is here**

**each module should be able to standalone, please let me know if you find that any cant**
#### /common/users/homeModules/dev/\<lang>
contains all config needed to run and develop code in that language
#### /common/users/homeModules/dev/ide/\<editor>.nix
contains code for code editors and IDEs

has a default module for all ides

*nvim is not an IDE*
#### /common/users/homeModules/dev/ide/jb/\<editor>.nix
contains all jet brains or IntelliJ based ides, eg: pycharm, android studio

has a default module for all ides

### /common/users/homeModules/scripts
contails shell scripts that are added to bash

also contains scripts writen in typescript and loaded via a package

see https://github.com/sadan4/scripts

> [!IMPORTANT]  
> While the scripts are included as a submodule (at /dotfiles/scripts) for easy editing, that is not what is used to build the system, an input is fetched and that is used

### /common/users/homeModules/jetbrains

> [!CAUTION]
> Unused and probably broken, will be removed in the future

### /common/users/homeModules/media

contains CLI and GUI tools for dealing with media (photo editors, video editors, ffmpeg, imagemagik, etc...)

default.nix just includes ./cli.nix and ./gui.nix

#### /common/users/homeModules/media/cli.nix

CLI tools for handling and managing media (ffmpeg, yt-dlp, ImageMagick, etc.)

#### /common/users/homeModules/media/gui.nix

GUI tools for handling and managing media (shotcut, pinta, gimp, obs, etc.)

#### /common/users/homeModules/media/davinci.nix

Davinci Resolve

> [!WARNING]  
> This is seperate because it often causes rebuilds of [SpiderMonkey](https://en.wikipedia.org/wiki/SpiderMonkey), which results in _long_ build times (>30 minutes on an i9-14900k)

### /common/users/homeModules/vscode

only has a default.nix, its vscode, what else do you expect

### /common/users/homeModules/fonts
only has a default.nix, files for each font planned in the future

> [!WARNING]  
> WIP

Font files to add

