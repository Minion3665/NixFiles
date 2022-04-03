{ pkgs, ... }: {
    home.packages = with pkgs; [
        nodejs-17_x
        yarn
    ];
}
