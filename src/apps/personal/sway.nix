{ pkgs, ... }: {
    wayland.windowManager.sway = {
        enable = true;
        wrapperFeatures.gtk = true;

        config = {
            assigns = {};
            bars = [];
            colors = {};

        };

        systemdIntegration = true;
    };

    home.packages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
    ];

    programs.zsh.profileExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
            exec systemd-cat -t sway sway
        fi
    '';
}