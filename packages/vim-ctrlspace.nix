{ vimUtils, fetchFromGitHub, lib }: vimUtils.buildVimPlugin {
  name = "vim-ctrlspace";
  src = fetchFromGitHub {
    owner = "minion3665";
    repo = "vim-ctrlspace";
    rev = "c1dfc35a208a86256763cbadb6770636b4720b6f";
    sha256 = "sha256-R3TC56UFEjXNpmmPn5XAw0H07leFt5NR2eKow93NkJI=";
  };
}
