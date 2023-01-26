{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      onehalf
      nvim-hlslens
      pkgs.nvim-scrollbar
      nvim-web-devicons
    ];
    extraConfig =
      builtins.readFile ./theme.vim
      + ''
        source ${./scrollbar.lua}
        source ${./icons.lua}
      '';
  };
}
