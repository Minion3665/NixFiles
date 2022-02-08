final: prev: let
  version = "135";

  jdk = prev.adoptopenjdk-hotspot-bin-15;

  Mindustry = final.fetchFromGitHub {
    owner = "Anuken";
    repo = "Mindustry";
    rev = "v${version}";
    sha256 = "URmjmfzQAVVl6erbh3+FVFdN7vGTNwYKPtcrwtt9vkg=";
  };
  Arc = final.fetchFromGitHub {
    owner = "Anuken";
    repo = "Arc";
    rev = "v${version}";
    sha256 = "pUUak5P9t4RmSdT+/oH/8oo6l7rjIN08XDJ06TcUn8I=";
  };
  soloud = final.fetchFromGitHub {
    owner = "Anuken";
    repo = "soloud";
    # this is never pinned in upstream, see https://github.com/Anuken/Arc/issues/39
    rev = "b33dfc5178fcb2613ee68136f4a4869cadc0b06a";
    sha256 = "1vf68i3pnsixch37285ib7afkwmlrc05v783395jsdjzj9i67lj3";
  };

  unpackPhase = ''
    cp -r ${Mindustry} Mindustry
    cp -r ${Arc} Arc
    chmod -R u+w -- Mindustry Arc
    cp ${prev.stb.src}/stb_image.h Arc/arc-core/csrc/
    cp -r ${soloud} Arc/arc-core/csrc/soloud
    chmod -R u+w -- Arc
  '';

  gradle_6 = (prev.gradleGen.override (old: { java = jdk; })).gradle_6_9;

  enableClient = prev.enableClient or true;
  enableServer = prev.enableServer or true;
in {
  mindustry-alpha-wayland = prev.mindustry-wayland.overrideAttrs (old: {
    inherit version unpackPhase;

    nativeBuildInputs = [
      prev.pkg-config
      gradle_6
      prev.makeWrapper
      jdk
    ] ++ prev.lib.optionals enableClient [
      prev.ant
      prev.copyDesktopItems
    ];

    meta.lib.broken = false;

    installPhase = with prev.lib; ''
      runHook preInstall
    '' + optionalString enableClient ''
      install -Dm644 desktop/build/libs/Mindustry.jar $out/share/mindustry.jar
      mkdir -p $out/bin
      makeWrapper ${jdk}/bin/java $out/bin/mindustry \
        --add-flags "-jar $out/share/mindustry.jar"
      install -Dm644 core/assets/icons/icon_64.png $out/share/icons/hicolor/64x64/apps/mindustry.png
    '' + optionalString enableServer ''
      install -Dm644 server/build/libs/server-release.jar $out/share/mindustry-server.jar
      mkdir -p $out/bin
      makeWrapper ${jdk}/bin/java $out/bin/mindustry-server \
        --add-flags "-jar $out/share/mindustry-server.jar"
    '' + ''
      runHook postInstall
    '';
  });
}
