{ pkgs, ... }: {
  home.packages = [
    pkgs.dogdns
  ];

  home.shellAliases = {
    dig = "${pkgs.dogdns}/bin/dog";
  };
}
