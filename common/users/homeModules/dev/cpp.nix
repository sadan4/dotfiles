{ pkgs, ... }:
{
  imports = [
    ../unstable.nix
    ./ide/jb/clion.nix
  ];
  home = {
    packages = with pkgs; [
      xorg.libX11.man
      meson
      autoPatchelfHook
      cmake
      # clang
      libgcc
      glib
      gdbgui
      bear
      glibc
      pinned.gdb
      lldb_19
      cpkg.ceserver
      unstable.llvmPackages_19.clang-tools
    ];
    file = {
      eslint_d_config = {
        source = ../../../../dotfiles/eslintrc.json;
        target = "./.config/.eslintrc.json";
      };
      gdb_config = {
        source = ../../../../dotfiles/gdb;
        target = "./.config/gdb";
        recursive = true;
      };
    };
  };
}
