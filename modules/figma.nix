{pkgs, ...}: {
  home.home.packages = [pkgs.figma];
  config.internal.allowUnfree = ["figma"];
}
