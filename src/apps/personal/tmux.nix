{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    newSession = true;
    tmuxinator.enable = true;
    extraConfig = ''
      bind k confirm-before kill-session
    '';
  };

  home.packages = [
    pkgs.elinks
    pkgs.zellij
  ];

  home.file.".config/tmuxinator/ide.yml".source = ./tmux/ide.yml;
}
