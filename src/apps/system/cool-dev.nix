{ pkgs, ... }: let
    host = "cool-dev.python.local";
in {
    services.nginx.virtualHosts."${host}" = {
        locations."/" = {
            proxyPass = "http://localhost:9982";
        };
    };

    networking.hosts = {
        "127.0.0.1" = [ "cool-dev.python.local" ];
    };
}
