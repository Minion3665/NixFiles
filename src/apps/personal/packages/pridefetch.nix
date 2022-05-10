{ pkgs, stdenv, ... }: stdenv.mkDerivation {
    name = "PrideFetch";
    src = pkgs.fetchFromGitHub {
        owner = "SpyHoodle";
        repo = "pridefetch";
        rev = "bb57d32e7a5368a68e8abca0b3059bf2e491c247";
        sha256 = "sha256-sYlt2LZHYSdHCmUPOi4vP/Tg2YNkCWSDoQxFKf5yQSM=";
    };
    
}
