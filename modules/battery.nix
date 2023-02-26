{ pkgs, ... }: {
  config = {
    services.auto-cpufreq.enable = true;

    environment = {
      systemPackages = with pkgs; [ cpufrequtils powertop ];
      persistence."/nix/persist".directories = [ "/var/cache/powertop" ];
    };
  };
}
