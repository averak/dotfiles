#!/usr/bin/env sh

while true; do
  read -t 60 -p "$1 [y/n]: " ANS || exit 1

  case $ANS in
    [Yy]*)
      exit 0
      ;;
    [Nn]*)
      exit 1
      ;;
    *)
      printf "\e[31mPlease enter y or n\e[0m\n"
      ;;
  esac
done
