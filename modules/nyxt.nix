{pkgs, ...}: {
  home.home = {
    packages = [pkgs.nyxt];

    file.".config/nyxt/init.lisp".source = ./nyxt/init.lisp;
  };
}
