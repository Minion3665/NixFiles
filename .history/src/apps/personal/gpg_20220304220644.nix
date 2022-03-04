{ config, pkgs, nixpkgs }: {
    programs.gpg.enable = true;
    services.gpg-agent = {
        enable = true;
        pinentryFlavor = "qt";
    };

    home.packages = with pkgs; [
      
    ]
}