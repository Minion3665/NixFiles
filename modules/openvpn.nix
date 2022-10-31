{ config, ... }: {
  config = {
    services.openvpn.servers = {
      clicks = {
        config = ''config ${config.sops.secrets."clicks-vpn/client.ovpn".path}'';
        autoStart = false;
      };
    };

    sops.secrets = {
      "clicks-vpn/auth.conf" = {
        mode = "0400";
        owner = config.users.users.root.name;
        group = config.users.users.nobody.group;
        sopsFile = ../secrets/clicks-vpn/auth.conf;
        format = "binary";
      };
      "clicks-vpn/client.ovpn" = {
        mode = "0400";
        owner = config.users.users.root.name;
        group = config.users.users.nobody.group;
        sopsFile = ../secrets/clicks-vpn/client.ovpn;
        format = "binary";
      };
    };
  };
}
