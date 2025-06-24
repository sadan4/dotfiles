{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rustup
      cargo-watch
      openssl
      # needed to use openssl
      pkg-config
    ];
  };
  programs = {
    zsh = {
      # Few horror things here
      # 1. rustup's completion is broken for zsh. See: https://github.com/rust-lang/rustup/issues/2268
      # 2. patch cant read the source file from stdin, so tmpfiles have to be used
      initExtra = ''
        TMP_RUSTUP_FILE=$(mktemp)
        ${pkgs.rustup}/bin/rustup completions zsh > "$TMP_RUSTUP_FILE"
        eval "$(patch -s -o - -i ${./rustupCompPatch.diff} $TMP_RUSTUP_FILE)"
        rm $TMP_RUSTUP_FILE
        unset TMP_RUSTUP_FILE
      '';
    };
  };
}
