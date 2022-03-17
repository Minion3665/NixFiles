{ pkgs, ... }: {
    home.packages = with pkgs; [
        cinnamon.nemo
    ];
}
