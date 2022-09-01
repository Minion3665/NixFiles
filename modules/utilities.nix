{pkgs, ...}: {
  # Basic shell scripting utilities, they don't deserve their own file but I use
  # them
  config.environment.systemPackages = with pkgs; [
    jq
    lnav
  ];
}
