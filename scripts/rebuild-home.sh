#!/bin/sh

cd "$(dirname ${BASH_SOURCE[0]})/.."

if [[ $(git diff --stat) != '' ]]; then
    read -ep "What did you change?: " changes
    git add .
    /usr/bin/env git commit -am "$changes"
fi

nix build .#homeManagerConfigurations.minion.activationPackage $1 --impure
./result/activate
unlink ./result