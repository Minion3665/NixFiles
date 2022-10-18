{ vimUtils
, fetchFromGitHub
,
}:
vimUtils.buildVimPlugin {
  name = "git-conflict-nvim";
  src = fetchFromGitHub {
    owner = "akinsho";
    repo = "git-conflict.nvim";
    rev = "80bc8931d4ed8c8c4d289a08e1838fcf4741408d";
    hash = "sha256-tBKGjzKK/SftivTgdujk4NaIxz8sUNyd9ULlGKAL8x8=";
  };
}
