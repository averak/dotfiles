#!/usr/bin/env bash
# Claude Code の hook から呼ばれ、macOS のデスクトップ通知を出す。
#
# 使い方: notify.sh <message> [sound] [volume]
#
# hook は stdin で JSON を受け取る。どのリポジトリの通知かを判別できるよう、cwd の末尾を subtitle に載せる。

set -euo pipefail

message=${1:?message is required}
sound=${2:-Glass}
volume=${3:-2}

cwd=$(jq -r '.cwd // ""')
project=$(basename "${cwd:-$PWD}")

exec "$(cd "$(dirname "$0")/../notify" && pwd)/macos.sh" "Claude Code" "$project" "$message" "$sound" "$volume"
