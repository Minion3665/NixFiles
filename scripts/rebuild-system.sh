#!/usr/bin/env bash

cd /home/minion/Nix

git add .

if [[ $(git diff --stat HEAD) != '' ]]; then
    read -e -p "What did you change?: " changes
    /usr/bin/env git commit -am "$changes"
fi

echo "Rebuilding and activating..."

sudo nixos-rebuild switch --flake .#default $1
