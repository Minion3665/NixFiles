{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [onehalf nvim-hlslens pkgs.nvim-scrollbar];
    extraConfig =
      builtins.readFile ./theme.vim
      + ''
        source ${./scrollbar.lua}
      '';
  };
}
