final: prev: let
  build = "24";
  sha = "sha256-QyexUZNn7QGHjXYO/+1kUebTmAzdVpwG9Ile8Uh3i8Q=";

  pname = "anytype";
  name = "${pname}-${build}";

  src = final.fetchurl {
#    url = "https://download.anytype.io/?action=download&key=desktop&id=${build}";
    url = "https://at9412003.fra1.digitaloceanspaces.com/Anytype-0.24.0.AppImage";
    sha256 = sha;
    name = "AnyType-${build}.AppImage";
  };

  appimageContents = final.appimageTools.extractType2 { inherit name src; };
in {
  anytype-latest = prev.appimageTools.wrapType2 {
    inherit name src;

    extraPkgs = pkgs: (prev.appimageTools.defaultFhsEnvArgs.multiPkgs pkgs)
      ++ [ pkgs.libsecret ];

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}
      install -m 444 -D ${appimageContents}/anytype2.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/anytype2.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/0x0/apps/anytype2.png \
        $out/share/icons/hicolor/512x512/apps/anytype2.png
    '';

    meta = with prev.lib; {
      description = "P2P note-taking tool";
      homepage = "https://anytype.io/";
      license = licenses.unfree;
      maintainers = with maintainers; [ bbigras ];
      platforms = [ "x86_64-linux" ];
    };
  };
}
