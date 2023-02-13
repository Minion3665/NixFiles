{
  config = {
    boot.plymouth.enable = true;
    boot.initrd.systemd.enable = true;
    boot.kernelParams = [ "quiet" ];
  };
}
