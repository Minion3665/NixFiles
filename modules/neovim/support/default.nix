{ pkgs, ... }: {
  programs.neovim = {
    extraPackages = with pkgs; [ pandoc unzip ];
    extraConfig = builtins.readFile ./filetypes.vim;
  };
}
