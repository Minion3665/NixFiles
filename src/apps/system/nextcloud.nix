{ pkgs, ... }: {
    services.nextcloud = {
        enable = true;
        hostName = "nextcloud.python.local";
    };

    networking.hosts = {
        "127.0.0.1" = [ "nextcloud.python.local" ];
    };
}
