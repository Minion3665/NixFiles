{ pkgs, ... }: let
    node = pkgs.nodejs-18_x;
in {
    home.packages = with pkgs; [
        node
        node2nix
        (yarn.override { nodejs = node; })
    ];
}
