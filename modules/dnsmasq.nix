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
        extraConfig = ''
          local=/local/
          domain=local
          expand-hosts
        '';
      };
      avahi = {
        enable = true;
        nssmdns = true;
        ipv4 = true;
        ipv6 = false;
        publish = {
          enable = true;
          addresses = true;
          workstation = true;
        };
      };
    };

    sops.secrets."dnsmasq-private.conf" = {
      format = "binary";
      sopsFile = ../secrets/dnsmasq-private.conf;
    };
  };
}
