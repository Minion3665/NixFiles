{username, ...}: {
  config = {
    hardware.sane.enable = true;
    users.users.${username}.extraGroups = [ "scanner" "lp" ];
  };
}
