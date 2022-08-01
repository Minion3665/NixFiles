{ pkgs, ... }: let
  config = { configFile, instanceName }: { pkgs, ... }: {
    imports = [
      configFile
    ];

    _module.args = { instance = instanceName; inputs = {}; };
  };

in {
  containers.caddy = {
    autoStart = false;
    privateNetwork = true;
    localAddress = "10.0.108.2";
    hostAddress = "10.0.108.1";
    config = config {
      configFile = /home/minion/Code/nix/oss-labs.eu/hosts/caddy/default.nix;
      instanceName = "caddy";
    };
  };

  containers.collabora = {
    autoStart = false;
    privateNetwork = true;
    localAddress = "10.0.108.3";
    hostAddress = "10.0.108.1";
    config = config {
      configFile = /home/minion/Code/nix/oss-labs.eu/hosts/collabora/default.nix;
      instanceName = "collabora";
    };
  };

  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "wlan0";
  };

  networking.hosts = {
    "10.0.108.2" = [ "collabora.oss-labs.eu" "meet.oss-labs.eu" "notes.oss-labs.eu" ];
  };
}
