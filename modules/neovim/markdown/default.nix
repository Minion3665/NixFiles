{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-markdown
      ncm2-markdown-subscope
      tabular
      markdown-preview-nvim
    ];
    extraConfig = builtins.readFile ./markdown.vim;
  };
}
