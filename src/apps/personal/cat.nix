{ pkgs, ... }: {
  home.packages = [
    pkgs.bat
  ];

  home.shellAliases = {
    cat = "${pkgs.bat}/bin/bat $@";
  };
}
