{ ... }: {
    programs.waybar = {
        enable = true;
        settings = [];  # TODO: Make settings
        style = ''
            window#waybar {
                background-color: red;
            }
        '';

        systemd = {
            enable = true;
            # target = "sway-session.target";
        };
    };

    systemd.user.targets.sway.Unit.Wants = [ "waybar.service" ];
}
