{ pkgs, ... }: {
  containers.caddy = {
    autoStart = false;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    config = import /home/minion/Code/nix/oss-labs.eu/hosts/caddy/default.nix;
  };

  containers.collabora = {
    autoStart = false;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.12";
    config = import /home/minion/Code/nix/oss-labs.eu/hosts/collabora/default.nix;
  };
}
