{ pkgs, ... }: {
    gtk = {
        enable = true;
        
        gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
        # gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; }; # Does not exist in my version of home-manager
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome.gnome-themes-extra;
        };
    };
}
