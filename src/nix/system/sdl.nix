{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        SDL2
        SDL2_ttf
        SDL2_net
        SDL2_sound
        SDL2_mixer
        SDL2_image
    ];
}
