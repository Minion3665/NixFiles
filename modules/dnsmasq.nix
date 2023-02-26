{ config, ... }: {
  config = {
    services = {
      nscd.enableNsncd = true;
      dnsmasq = {
        enable = true;
        settings = {
          server = [ "1.1.1.1" "1.0.0.1" ];
          conf-file = config.sops.secrets."dnsmasq-private.conf".path;
        };
      };
    };

    sops.secrets."dnsmasq-private.conf" = {
      format = "binary";
      sopsFile = ../secrets/dnsmasq-private.conf;
    };
  };
}
