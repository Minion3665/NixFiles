{pkgs, ...}: {
  programs.neovim = {
    extraPackages = [pkgs.pandoc];
    extraConfig = builtins.readFile ./filetypes.vim;
  };
}
