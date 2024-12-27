#!/usr/bin/env bash

_confirm() {
  while true; do
    read -p "$1 [y/n]: " -r

    case $REPLY in
    [Yy])
      echo ""
      return 0
      ;;
    [Nn])
      echo ""
      return 1
      ;;
    *)
      echo ""
      printf "\e[31mPlease enter y or n\e[0m\n"
      ;;
    esac
  done
}

tput=$(command -v tput)
if [ -n "$tput" ]; then
  ncolors=$($tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  _STYLE_RED="$(tput setaf 1)"
  _STYLE_GREEN="$(tput setaf 2)"
  _STYLE_YELLOW="$(tput setaf 3)"
  _STYLE_NONE="$(tput sgr0)"
else
  unset _STYLE_RED _STYLE_GREEN _STYLE_GREEN _STYLE_NONE
fi

_log_info() {
  printf "%s[INFO] %s%s\n" "${_STYLE_GREEN}" "${_STYLE_NONE}" "$@"
}

_log_error() {
  printf "%s[ERROR] %s%s\n" "${_STYLE_RED}" "${_STYLE_NONE}" "$@"
}

_log_warn() {
  printf "%s[WARN] %s%s\n" "${_STYLE_YELLOW}" "${_STYLE_NONE}" "$@"
}
