{ ... }: {
    programs.waybar = {
        enable = true;
        settings = [];  # TODO: Make settings
        style = ''
            window#waybar {
                background: rgba(0, 0, 0, 0);
            }
        '';

        systemd = {
            enable = true;
            # target = "sway-session.target";
        };
    };

    systemd.user.targets.sway.Unit.Wants = [ "waybar.service" ];
}
