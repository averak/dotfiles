#!/usr/bin/env sh

# $1: install cmd
# $2: target packages
# $3: installed packages

packages=""

for pkg in $2; do
  printf "check ${pkg}..."
  if echo "$3" | grep -xq ${pkg}; then
    printf "\e[32mOK\e[0m\n"
  else
    printf "\e[31mNot installed\e[0m\n"
    packages="${packages} ${pkg}"
  fi
done

echo ""

for pkg in ${packages}; do
  $1 ${pkg}
done
