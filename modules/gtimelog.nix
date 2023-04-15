{ pkgs
, home
, config
, username
, gtimelog
, lib
, ...
}: {
  home.home = {
    packages = [
      (pkgs.gtimelog.overrideAttrs (oldAttrs: {
        src = gtimelog;
        makeWrapperArgs = [
          "--set GIO_MODULE_DIR ${lib.makeSearchPathOutput "out"
            "lib/gio/modules" (with pkgs; [
              glib-networking
            ])}"
        ];
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.gobject-introspection ];
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.glib-networking ];
      }))
    ];
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".gtimelog" ];
  config.sops.secrets."gtimelogrc.toml" = {
    owner = config.users.users.${username}.name;
    group = config.users.users.${username}.group;
    format = "binary";
    sopsFile = ../secrets/gtimelogrc.toml;
    path = "${home.home.homeDirectory}/.gtimelog/gtimelogrc";
  };
}
