{ pkgs, ... }: let
    pinentry-multiplexed = pkgs.writeScriptBin "pinentry-multiplexed" ''
        case $PINENTRY_USER_DATA in
        tty)
            exec ${pkgs.pinentry.tty}/bin/pinentry "$@"
            ;;
        none)
            exit 1
            ;;
        *)
            exec ${pkgs.pinentry.qt}/bin/pinentry "$@"
        esac
    '';
in {
    programs.gpg.enable = true;
    services.gpg-agent = {
        enable = true;
        extraConfig = ''
          pinentry-program ${pinentry-multiplexed}/bin/pinentry-multiplexed
        '';
        pinentryFlavor = null;
    };

    home.packages = [
        pinentry-multiplexed
    ];
}
