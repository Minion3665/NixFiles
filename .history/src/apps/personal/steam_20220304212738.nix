{ config, pkgs, nixpkgs }: {
    home.packages = with pkgs; [
        steam-run
    ];  # Use *only* for packages that need no configuration;
    # other packages should go in ./apps/personal/

    programs.steam.enable = true;
}