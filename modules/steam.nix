{ pkgs
, username
, config
, ...
}: {
  config = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;

      package = pkgs.steam.override
        {
          extraLibraries = pkgs: with config.hardware.opengl; [ package ] ++ extraPackages;
        };
    };
    hardware.steam-hardware.enable = true;

    internal.allowUnfree = [ "steam" "steam-original" "steam-runtime" "steam-run" ];
    environment = {
      persistence."/large/persist".users.${username}.directories = [ ".local/share/Steam" ];
      systemPackages = with pkgs; [
        gamescope
        gamemode
        sfs-select /*(
        writeTextDir "share/applications/steam.desktop" ''
          [Desktop Entry]
          Name=Steam
          Comment=Application for managing and playing games on steam
          Exec=${pkgs.gamescope}/bin/gamescope -w 1920 -h 1080 -- ${pkgs.steam}/bin/steam
          Icon=steam
          Terminal=false
          Type=Application
          Categories=Network;FileTransfer;Game;
          MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
          Actions=Store;Community;Library;Servers;Screenshots;News;Settings;BigPicture;Friends;
          PrefersNonDefaultGPU=true
          X-KDE-RunOnDiscreteGpu=true
        ''
        )*/
      ];
    };
    boot.kernel.sysctl."dev.i915.perf_stream_paranoid" = "0";
  };
}
