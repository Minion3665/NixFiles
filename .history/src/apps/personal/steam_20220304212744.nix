{ config, pkgs, nixpkgs }: {
    home.packages = with pkgs; [
        steam-run
    ];

    programs.steam.enable = true;
}