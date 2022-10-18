{ pkgs
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
    file.".gtimelog/gtimelogrc".source = ./gtimelog/gtimelogrc.toml;
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [ ".gtimelog" ];
}
