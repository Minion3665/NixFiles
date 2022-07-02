{ pkgs, ... }: {
  home.packages = [
    pkgs.iproute2
  ];

  home.shellAliases = {
    ip = "${pkgs.iproute2}/bin/ip -c --brief";
    ipo = "${pkgs.iproute2}/bin/ip";
  };
}
