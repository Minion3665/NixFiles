{ pkgs, ... }: {
    home.packages = with pkgs; [
        oneshot-game
    ];
}
