{ lib, ... }: let
    variables = import ../../common/variables.nix;
in {
    lib.writeText."/home/${variables.username}/.profile" = ''
        
    '';
}