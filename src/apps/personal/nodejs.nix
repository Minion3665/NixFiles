{ pkgs, ... }: let
    node = pkgs.nodejs-18_x;
in {
    home.packages = with pkgs; [
        node
        (yarn.override { nodejs = node; })
    ];
}
