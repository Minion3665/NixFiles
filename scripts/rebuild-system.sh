#!/bin/sh

cd /home/minion/Nix

git add .

if [[ $(git diff --stat HEAD) != '' ]]; then
    read -ep "What did you change?: " changes
    /usr/bin/env git commit -am "$changes"
fi

sudo nixos-rebuild switch --flake .#default $1
