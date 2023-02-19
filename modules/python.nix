{ pkgs, ... }: {
  home.home.packages = [
    (pkgs.python3.withPackages
      (pyPkgs: with pyPkgs; [
        rope
      ]))
  ];
}
