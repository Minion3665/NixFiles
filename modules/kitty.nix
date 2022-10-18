{ pkgs, ... }: {
  home = {
    programs.kitty = {
      enable = true;

      theme = "One Half Dark";

      settings = {
        enable_audio_bell = "no";
        visual_bell_duration = "0.1";
        symbol_map = "U+E0A0-U+E0A3 PowerlineSymbols";
        disable_ligatures = "cursor";
      };
    };
    programs.zsh.initExtra = ''
      if test -n "$KITTY_INSTALLATION_DIR"; then
      export KITTY_SHELL_INTEGRATION="enabled"
      autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
      kitty-integration
      unfunction kitty-integration
      fi
    '';

    home.shellAliases = {
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";
    };
  };
}
