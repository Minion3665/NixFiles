{ pkgs, ... }: {
  config = {
    services.auto-cpufreq.enable = true;
    services.upower.criticalPowerAction = "Hibernate";

    environment = {
      systemPackages = with pkgs; [ cpufrequtils powertop ];
      persistence."/nix/persist".directories = [ "/var/cache/powertop" ];
    };
  };
}
