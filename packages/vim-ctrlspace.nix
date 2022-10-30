{ vimUtils, fetchFromGitHub, lib }: vimUtils.buildVimPlugin {
  name = "vim-ctrlspace";
  src = fetchFromGitHub {
    owner = "vim-ctrlspace";
    repo = "vim-ctrlspace";
    rev = "05b58e916cea62577462d36bbb88933e8454f2d3";
    sha256 = "sha256-wQuQTNmU1qujQJ3oU2pSTQaVDa4ZChr1fkjFbILLt+w=";
  };
}
