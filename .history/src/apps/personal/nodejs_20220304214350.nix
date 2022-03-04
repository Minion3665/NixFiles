{ config, pkgs, nixpkgs }: {
    home.packages = with pkgs; [
        spotify
    ];

    programs.steam.enable = true;
}