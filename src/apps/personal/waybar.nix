{ ... }: {
    programs.waybar = {
        enable = true;
        settings = [];  # TODO: Make settings
        style = ''
            window#waybar {
                background: rgba(0, 0, 0, 0);
            }

            window#waybar * * * {
                background: @theme_base_color;
                color: @theme_text_color;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 5px;
            }
        '';

        systemd = {
            enable = true;
            # target = "sway-session.target";
        };
    };

    systemd.user.targets.sway.Unit.Wants = [ "waybar.service" ];
}
