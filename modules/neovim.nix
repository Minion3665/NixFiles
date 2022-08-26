args @ {
  pkgs,
  lib,
  home,
  ...
}: let
  utils = import ../utils lib;
in {
  config = {
    environment.variables = {
      EDITOR = "nvim";
    };
    environment.defaultPackages = [
      pkgs.perl
      pkgs.rsync
      pkgs.strace
      pkgs.neovim
    ]; # The basic default packages, although with nvim replacing nano
  };

  home = {
    imports = lib.pipe ./neovim [
      utils.dirsIn
      utils.importAll
      (map (f:
        if builtins.typeOf f == "lambda"
        then f args
        else f))
    ];
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
