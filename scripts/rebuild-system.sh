#!/bin/sh

cd "$(dirname ${BASH_SOURCE[0]})/.."

git add .

if [[ $(git diff --stat HEAD) != '' ]]; then
    read -ep "What did you change?: " changes
    /usr/bin/env git commit -am "$changes"
fi

sudo nixos-rebuild switch --impure --flake .# $1
./result/activate
unlink ./result
