final: prev: let
  src = final.fetchFromGitHub {
    owner = "winfsp";
    repo = "hubfs";
    rev = "1ba013d3fe54de01c52bd74d98037fe4c0029d6e";
  } + "/src";
in {
  hubfs = final.buildGoModule {
    name = "hubfs";
    inherit src;
    vendorSha256 = null;
  };
}