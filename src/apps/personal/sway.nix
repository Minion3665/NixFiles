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

    systemd.user.targets.sway-session.Unit = {
        Description = "Sway compositor session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
    };

    programs.zsh.profileExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
            exec systemd-cat -t sway sway
        fi
    '';
}