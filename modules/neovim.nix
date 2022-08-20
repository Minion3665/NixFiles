{pkgs, ...}: {
  config = {
    environment.variables = {
      EDITOR = "${pkgs.nvim}/bin/nvim";
    };
    environment.defaultPackages = [
      pkgs.perl
      pkgs.rsync
      pkgs.strace
      pkgs.nvim # I'm installing vim here even though it isn't normally a default package, as I've removed nano
    ]; # The basic default packages, although without nano
  };
}
