{ pkgs, ... }: {
    home.packages = with pkgs; [
        syncplay
        vlc
    ];
}
