{kmonad, ...}: {
  imports = [kmonad.nixosModules.default];

  config.services.kmonad = {
    enable = false;
    keyboards.laptop-internal = {
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      config = builtins.readFile ./kmonad/config.kbd;
    };
  };
}
