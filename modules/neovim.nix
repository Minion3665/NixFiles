args @ { pkgs
, lib
, home
, username
, utils
, ...
}: {
  config = {
    environment = {
      variables = {
        EDITOR = "${pkgs.neovim}/bin/nvim";
      };
      defaultPackages = [
        pkgs.perl
        pkgs.rsync
        pkgs.strace
        pkgs.neovim
      ]; # The basic default packages, although with nvim replacing nano
      persistence."/nix/persist".users.${username}.directories = [
        ".local/share/cspell"
        ".codeium"
        ".config/nvim/undo"
      ];
    };
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
    home = {
      packages = with pkgs; [ neovide xclip ];
      sessionVariables = {
        EDITOR = "${home.programs.neovim.finalPackage}/bin/nvim";
      };
    };
  };
}
