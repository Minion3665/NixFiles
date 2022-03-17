{ pkgs, ... }: {
    home.packages = with pkgs; [
        hubfs
    ];
}
