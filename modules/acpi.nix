{
  pkgs,
  config,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [acpi acpitool];
    services.acpid.enable = true;
    boot.extraModulePackages = with config.boot.kernelPackages; [acpi_call];
  };
}
