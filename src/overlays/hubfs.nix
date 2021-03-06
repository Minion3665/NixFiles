final: prev: let
  version = "1ba013d3fe54de01c52bd74d98037fe4c0029d6e";

  src = final.fetchFromGitHub {
    owner = "winfsp";
    repo = "hubfs";
    rev = version;
    hash = "sha256-R1nCdua0gacXrglQ4AZfxnO3ngVECCKKiUOgp3dWRGg=";
  } + "/src";
in {
  hubfs = final.buildGoModule {
    inherit src version;

    name = "hubfs";

    buildInputs = with final; [
        fuse3
        fuse
        fuse-common
        makeWrapper
    ];

    checkPhase = ":"; # Bit of a hack here; we need to disable tests as we can't get FUSE inside the build derivation to test the package

    vendorSha256 = "sha256-sT3H1iFSakLHWKhzRcJz2RXf2Owm+8DQy3h3O8MO2nY=";

    proxyVendor = true;

    ldflags = [
      "-X main.GitVersion=${version}"
      "-X main.GitVersionFuse=[vendored]"
      "-X main.BuildDate=unknown"
    ];

    postInstall = ''
      wrapProgram $out/bin/hubfs \
        --suffix PATH : ${final.lib.makeBinPath [ final.fuse final.fuse3 ]}
      ln -s $out/bin/hubfs $out/bin/mount.fuse.hubfs
    '';

    meta = with final.lib; {
      description = "GitHub as a FUSE mount";
      license = licenses.agpl3;
      homepage = "https://github.com/winfsp/hubfs";
      maintainers = with maintainers; [ minion3665 ];
      platforms = platforms.unix;
    };
  };
}
