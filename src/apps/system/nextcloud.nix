{ pkgs, ... }: {
    services.nextcloud = {
        enable = true;
        hostName = "nextcloud.python.local";
        package = pkgs.nextcloud24;
        config = {
            adminpassFile = "/home/minion/Private/nextcloud-adminpassFile";
        };
    };

    networking.hosts = {
        "127.0.0.1" = [ "nextcloud.python.local" ];
    };
}
