{ config, pkgs, nixpkgs }: {
    home.packages = with pkgs; [
        spotify
    ];
}