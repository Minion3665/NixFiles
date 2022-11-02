{pkgs, ...}: {
  config.services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}
