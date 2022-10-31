{ pkgs
, nixpkgs-minion
, system
, ...
}: {
  programs.neovim = {
    plugins = [
      nixpkgs-minion.legacyPackages.${system}.vimPlugins.vim-astro
      pkgs.vimPlugins.vim-closetag
    ];

    extraConfig = builtins.readFile ./astro.vim;
  };
}
