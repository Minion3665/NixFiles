{ vimUtils
, fetchFromGitHub
,
}:
vimUtils.buildVimPlugin {
  name = "wiki.vim";
  src = fetchFromGitHub {
    owner = "lervag";
    repo = "wiki.vim";
    rev = "d53f4f4b243147fc0ed9e89a9c8ade89abb5480f";
    hash = "sha256-1NuEqKaNO0nvxq5kKjLNGtNeGyVh8g7LM9X7Wyy7h1Q=";
  };
}
