{pkgs, ...}: {
  programs = {
    neovim = {
      extraConfig = builtins.readFile ./remote.vim;
      extraPackages = [
        pkgs.neovim-remote
      ];
    };
    zsh.initExtra = ''
      if [ ! -z "$NVIM" ]; then
        alias nvim="${pkgs.neovim-remote}/bin/nvr"
        alias vim="${pkgs.neovim-remote}/bin/nvr"
        alias vi="${pkgs.neovim-remote}/bin/nvr"
      fi
    '';
  };
}
