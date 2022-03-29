{ pkgs, ... }: let
    figma = (pkgs.figma-linux.override { fonts = with pkgs; [ open-fonts roboto roboto-mono nerdfonts ]; });
in {
    home.packages = [
        figma
    ];
}
