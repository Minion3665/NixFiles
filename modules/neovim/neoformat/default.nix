{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      neoformat
    ];
    extraConfig = builtins.readFile ./setup.vim;
    extraPackages = with pkgs; [
      nodePackages.prettier
      alejandra
      rustfmt
      shfmt
    ];
  };
}