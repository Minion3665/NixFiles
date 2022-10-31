{ vimUtils
, fetchFromGitHub
, lib
,
}:
vimUtils.buildVimPlugin {
  name = "vim-ctrlspace";
  src = fetchFromGitHub {
    owner = "vim-ctrlspace";
    repo = "vim-ctrlspace";
    rev = "5e444c6af06de58d5ed7d7bd0dcbb958f292cd2e";
    sha256 = "sha256-EJFaWTVPqQpAewPq7VT0EOgMnL3+6Hl9u5oQZJqItUM=";
  };
}
