{ vimUtils
, fetchFromGitHub
,
}:
vimUtils.buildVimPlugin {
  name = "nvim-scrollbar";
  src = fetchFromGitHub {
    owner = "petertriho";
    repo = "nvim-scrollbar";
    rev = "ce0df6954a69d61315452f23f427566dc1e937ae";
    hash = "sha256-EqHoR/vdifrN3uhrA0AoJVXKf5jKxznJEgKh8bXm2PQ=";
  };
}
