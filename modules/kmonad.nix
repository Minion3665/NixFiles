{ kmonad, ... }: {
  imports = [ kmonad.nixosModules.default ];

  config = {
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };

    services.kmonad = {
      enable = true;
      keyboards.laptop-internal = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./kmonad/config.kbd;

        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = true;
        };
      };
    };
    hardware.uinput.enable = true;
  };
}
