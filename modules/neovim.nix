{pkgs, ...}: {
  config = {
    environment.variables = {
      EDITOR = "${pkgs.neovim}/bin/nvim";
    };
    environment.defaultPackages = [
      pkgs.perl
      pkgs.rsync
      pkgs.strace
      pkgs.neovim # I'm installing vim here even though it isn't normally a default package, as I've removed nano
    ]; # The basic default packages, although without nano
  };
}
