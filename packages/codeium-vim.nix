{ vimUtils
, fetchFromGitHub
}: vimUtils.buildVimPluginFrom2Nix { 
  name = "codeium.vim";
  src = fetchFromGitHub {
    owner = "Exafunction";
    repo = "codeium.vim";
    rev = "cf3bbfa52658fa4380ea2bb764493356f04768c3";
    sha256 = "sha256-HoTw330lS4bvJJaukZgbTTzr8t5O8mMkpHqi+dF8jqY=";
  };
}
