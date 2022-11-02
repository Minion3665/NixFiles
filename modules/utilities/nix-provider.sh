#!/usr/bin/env bash
if [ "$1" = "" ]
then
  read -ep "What command are you looking for?: " CMD
else
  CMD=$1
fi

LOCATION=$(command -V "$CMD" 2>&1 | sed -rn "s/.* (.*)$/\1/p")

if [ "$LOCATION" = "found" ] # Not found
then
  echo "The command $CMD wasn't found"
  exit 1
fi

if [ "$LOCATION" = "builtin" ] # Shell builtin
then
  echo "The command $CMD is a shell builtin"
  exit 0
fi

RESOLVED_LOCATION=$(readlink -f "$LOCATION")

if [[ ! "$RESOLVED_LOCATION" =~ ^\/nix\/store\/.*-.*-.*$ ]];
then
  echo "The command $CMD is at $RESOLVED_LOCATION"
  exit 0
fi

PACKAGE=$(echo "$RESOLVED_LOCATION" | sed -rn "s/\/nix\/store\/.*-(.*)-.*/\1/p")

SEARCHED=$(nix search "nixpkgs#$PACKAGE" 2>&1)

if [ "$SEARCHED" = "error: no results for the given search term(s)!" ]
then
  echo "The command $CMD is at $RESOLVED_LOCATION"
  exit 0
fi

echo "The command $CMD is from:"
echo "$SEARCHED"
echo "Which is available at $RESOLVED_LOCATION"
