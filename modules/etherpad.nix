{ pkgs, ... }: {
  config.environment.systemPackages = [ pkgs.etherpad ];
}
