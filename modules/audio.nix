{pkgs, ...}: {
  home.home.packages = with pkgs; [pulseaudio pulsemixer];
  config = {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
