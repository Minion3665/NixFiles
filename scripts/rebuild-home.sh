#!/bin/sh

cd "$(dirname ${BASH_SOURCE[0]})/.."

git add .

if [[ $(git diff --stat HEAD) != '' ]]; then
    read -ep "What did you change?: " changes
    /usr/bin/env git commit -am "$changes"
fi

home-manager switch --flake .#$USER $1
