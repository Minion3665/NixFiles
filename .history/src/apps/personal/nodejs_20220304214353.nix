{ config, pkgs, nixpkgs }: {
    home.packages = with pkgs; [
        node
    ];

    programs.steam.enable = true;
}