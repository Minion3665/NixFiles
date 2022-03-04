{ config, pkgs, nixpkgs }: {
    programs.gpg.enable = true;
    services.gpg-agent = {
        enable = true;
        pine
    };
}