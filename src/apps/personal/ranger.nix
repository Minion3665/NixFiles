{ pkgs, ... }: {
  home.packages = [
    pkgs.ranger
  ];

  home.shellAliases = {
    ide = "${pkgs.ranger}/bin/ranger";
  };
}
