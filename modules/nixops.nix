{ pkgs, ... }: {
  home.home.packages = [ pkgs.nixopsUnstable ];
}
