{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-markdown
      ncm2-markdown-subscope
      markdown-preview-nvim
      vim-table-mode
    ];
    extraConfig = builtins.readFile ./markdown.vim;
  };
}
