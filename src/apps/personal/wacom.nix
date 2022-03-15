{ pkgs, ... }: {
    home.packages = with pkgs; [
        libwacom
    ];
}
