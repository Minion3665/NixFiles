{ ... }: {
    gtk = {
        enable = true;
        gtk.theme.package = pkgs.juno-theme;
        gtk.theme.name = "Juno";
    };
}
