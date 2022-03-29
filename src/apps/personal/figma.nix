{ pkgs, ... }: {
    home.packages = with pkgs; [
        figma-linux.override { fonts = [ open-fonts roboto roboto-mono nerdfonts ]; }
    ];
}
