{ pkgs, ... }: {
  home = {
    home.packages = [ pkgs.nb ];
    programs.zsh.initExtra = ''
      export NB_DIR=/home/minion/Documents/wiki/notes
    '';
  };
}
