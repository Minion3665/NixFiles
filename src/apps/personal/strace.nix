{ pkgs, ... }: {
  home.packages = [
    pkgs.strace
  ];
}
