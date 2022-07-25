#!/usr/bin/env bash

cd /home/minion/Nix

git add .

if [[ $(git diff --stat HEAD) != '' ]]; then
    read -e -p "What did you change?: " changes
    /usr/bin/env git commit -am "$changes"
fi

nix build .#homeConfigurations.${USER}.activationPackage $1 || exit 1

nix profile list \
  | { grep 'home-manager-path$' || test $? = 1; } \
  | awk -F ' ' '{ print $4 }' \
  | cut -d ' ' -f 4 \
  | xargs -t $DRY_RUN_CMD nix profile remove $VERBOSE_ARG
# ^ Remove old profiles; from https://github.com/nix-community/home-manager/blob/8d38ca886880265d523a66fe3da4d42e92ab0748/modules/home-environment.nix#L582

result/activate
unlink result
