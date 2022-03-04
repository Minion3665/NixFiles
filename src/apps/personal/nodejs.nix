{ config, pkgs, nixpkgs }: {
    home.packages = with pkgs; [
        nodejs-17_x
    ];

    programs.steam.enable = true;
}