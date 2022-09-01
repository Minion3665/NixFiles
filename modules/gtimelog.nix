{
  pkgs,
  username,
  gtimelog,
  lib,
  ...
}: {
  home.home = {
    packages = [
      (pkgs.gtimelog.overrideAttrs (oldAttrs: {
        src = gtimelog;
        makeWrapperArgs = [
          "--set GI_TYPELIB_PATH ${lib.makeSearchPathOutput "lib"
            "lib/girepository-1.0" (with pkgs; [
              gtk3
              libsoup
              libsecret
              pango
              harfbuzz
              gdk-pixbuf
              atk
            ])}"
          "--set GIO_MODULE_DIR ${lib.makeSearchPathOutput "out"
            "lib/gio/modules" (with pkgs; [
              glib-networking
            ])}"
        ];
        buildInputs = oldAttrs.buildInputs ++ [pkgs.glib-networking];
      }))
    ];
    file.".gtimelog/gtimelogrc".source = ./gtimelog/gtimelogrc.toml;
  };

  config.environment.persistence."/nix/persist".users.${username}.directories = [".gtimelog"];
}
