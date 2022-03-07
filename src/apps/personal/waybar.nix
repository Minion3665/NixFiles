{ ... }: {
    programs.waybar = {
        enable = true;
        settings = [];  # TODO: Make settings
        style = null;  # TODO: Style waybar

        systemd = {
            enable = true;
            # target = "sway-session.target";
        };
    };

    systemd.user.targets.waybar.enable = true;
}
