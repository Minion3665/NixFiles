{ pkgs, ... }: let
    node = pkgs.nodejs-17_x
in {
    home.packages = with pkgs; [
        node
        (yarn.override { nodejs = node; })
    ];
}
