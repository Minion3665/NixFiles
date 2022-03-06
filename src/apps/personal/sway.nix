{ pkgs, ... }: {
    wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;

        config = {
            assigns = {};
            bars = [];
            colors = {};

        };
    };

    home.packages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
    ];

    systemd.user.targets.sway-session.Units = {
        description = "Sway compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
    };
}