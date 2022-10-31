{pkgs, ...}: {
  programs.neovim = {
    plugins = [
      pkgs.vimPlugins.venn-nvim
    ];
    extraConfig = ''
      source ${./venn.lua}
    '';
  };
}
