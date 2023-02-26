{ pkgs, ... }: {
  config.environment.shells = with pkgs; [ bashInteractive zsh nushell ];
}
