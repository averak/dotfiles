#!/usr/bin/env bash
# Codex CLI の notify から呼ばれ、macOS のデスクトップ通知を出す。
#
# Codex は通知内容を JSON 文字列として第1引数に渡す。JSON には作業ディレクトリが含まれないので、
# どのリポジトリの通知かは Codex から引き継いだカレントディレクトリで判断する。

set -euo pipefail

payload=${1:-}
message=$(printf '%s' "$payload" | jq -r '.["last-assistant-message"] // "Codex task completed"')
project=$(basename "$PWD")

exec "$(cd "$(dirname "$0")/../notify" && pwd)/macos.sh" "Codex" "$project" "$message" Purr 1
