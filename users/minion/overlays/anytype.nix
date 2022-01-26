final: prev: let
  build = "54367901";
  sha = "sha256-kVM/F0LsIgMtur8jHZzUWkFIcfHe0i8y9Zxe3z5SkVM=";

  pname = "anytype";
  name = "${pname}-${build}";

  src = final.fetchurl {
    url = "https://download.anytype.io/?action=download&key=desktop&id=${build}";
    sha256 = sha;
    name = "AnyType-${build}.AppImage";
  };

  contents = final.appimageTools.extractType2 { inherit name src; };
in {
  anytype-latest = prev.anytype.overrideAttrs (old: {
    version = build;
    inherit name src;

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}
      install -m 444 -D ${contents}/anytype2.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/anytype2.desktop \
        --replace 'Exec=AppRun' 'Exec=${name}'
      install -m 444 -D ${contents}/usr/share/icons/hicolor/0x0/apps/anytype2.png \
        $out/share/icons/hicolor/512x512/apps/anytype2.png
    '';
  });
}
