{ pkgs, ... }: {
  programs.kitty = {
    enable = true;

    theme = "One Half";

    settings = {
      enable_audio_bell = "no";
      visual_bell_duration = "0.1";
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
}
