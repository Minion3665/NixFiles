{ config, ... }: {
  config = {
    services = {
      nscd.enableNsncd = true;
      dnsmasq = {
        enable = true;
        servers = [ "1.1.1.1" "1.0.0.1" ];

        extraConfig = ''
          conf-file=${config.sops.secrets."dnsmasq-private.conf".path}
        '';
      };
    };

    sops.secrets."dnsmasq-private.conf" = {
      format = "binary";
      sopsFile = ../secrets/dnsmasq-private.conf;
    };
  };
}
