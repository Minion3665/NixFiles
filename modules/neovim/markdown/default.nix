{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-markdown
      ncm2-markdown-subscope
      markdown-preview-nvim
      vim-table-mode
      vim-pandoc
    ];
    extraConfig = builtins.readFile ./markdown.vim;
  };
}
