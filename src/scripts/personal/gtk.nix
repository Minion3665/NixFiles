{ pkgs, ... }: {
    gtk = {
        enable = true;
        theme = {
            package = pkgs.juno-theme;
            name = "Juno";
        };
    };
}
