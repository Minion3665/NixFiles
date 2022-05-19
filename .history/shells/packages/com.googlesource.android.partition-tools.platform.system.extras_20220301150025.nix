{ pkg }: let
    src = builtins.fetchTarball {
        url = "https://android.googlesource.com/platform/system/extras/+archive/master/partition_tools.tar.gz";
    };
in pkgs.stdenv.mkDerivation {
    inherit src;
    name = "partition-tools";
}