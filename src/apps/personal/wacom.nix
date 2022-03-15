{ pkgs, ... }: {
    home.packages = with pkgs; [
        opentabletdriver
    ];
}
