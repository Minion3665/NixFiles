{ pkgs, ... }: {
  home.home = {
    packages = [
      (pkgs.python3.withPackages
        (pyPkgs: with pyPkgs; [
          rope
        ]))
    ];
    sessionVariables = {
      PYTHONPATH = "${pkgs.apparmor-utils}/lib/python3.10/site-packages:${pkgs.libapparmor.python}/lib/python3.10/site-packages";
    };
  };
}
