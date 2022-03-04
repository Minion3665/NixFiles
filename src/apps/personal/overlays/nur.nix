final: prev: let
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz");
in {
  nur = nur {
    nurpkgs = prev;
    pkgs = prev;
  };
}