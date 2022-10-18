{ pkgs
, lib
, ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      airline
      vim-airline-clock
    ];
    extraConfig = lib.pipe [ ./tabline.vim ./theme.vim ./parts.vim ] [
      (map builtins.readFile)
      (builtins.concatStringsSep "\n")
    ];
  };

  home.file.".config/nvim/autoload/airline/themes/onehalf.vim".source = ./onehalf-dark-airline.vim;
}
