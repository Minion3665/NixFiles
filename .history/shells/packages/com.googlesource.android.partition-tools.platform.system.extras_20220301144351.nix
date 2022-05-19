{ pkgs }: let
    src = builtins.fetchTarball {
        url = "https://android.googlesource.com/platform/system/extras/+archive/master/partition_tools.tar.gz";
    };
in stdenv.mkDerivation {
    inherit src;
    name = "partition-tools";
    buildInputs = [ gcc ];
    system = builtins.
}