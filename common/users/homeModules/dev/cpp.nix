{ pkgs, unstable, ... }:
{
  home = {
    packages = with pkgs; [
      meson
      autoPatchelfHook
      cmake
      # clang
      libgcc
      glib
      bear
      glibc
      gdb
      lldb_19
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
