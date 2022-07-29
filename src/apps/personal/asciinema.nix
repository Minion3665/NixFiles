{ pkgs, pkgs-21-11, ... }: {
    home.packages = [ pkgs.asciinema ((import ./asciinema/default.nix { pkgs = pkgs; nodejs = pkgs.nodejs; }).package.override {
        buildInputs = [ pkgs.makeWrapper ];

        preRebuild = ''
        wrapProgram $out/lib/node_modules/asciicast2gif-nix/node_modules/asciicast2gif/asciicast2gif --suffix PATH : ${pkgs.lib.makeBinPath [ pkgs.imagemagick pkgs.gifsicle pkgs-21-11.phantomjs2 ]}
        export PATH=$PATH:${pkgs.lib.makeBinPath [ pkgs.imagemagick pkgs.gifsicle pkgs-21-11.phantomjs2 ]}
        mkdir -p $out/bin
        ln -s $out/lib/node_modules/asciicast2gif-nix/node_modules/asciicast2gif/asciicast2gif $out/bin/asciicast2gif
        '';
    }) ];
}
