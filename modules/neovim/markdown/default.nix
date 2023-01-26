{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-markdown
      ncm2-markdown-subscope
      markdown-preview-nvim
      vim-table-mode
      vim-pandoc
      goyo-vim
      limelight-vim
    ];
    extraConfig = ''
      ${builtins.readFile ./markdown.vim}
      ${builtins.readFile ./limelight.vim}
    '';
  };
}
