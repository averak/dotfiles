#!/usr/bin/env bash
# macOS のデスクトップ通知を出す。Claude Code と Codex CLI の双方の通知フックから呼ばれる。
#
# 使い方: macos.sh <title> <subtitle> <message> [sound] [volume]
#
# sound は /System/Library/Sounds にあるファイルのベース名を指定する。存在しない名前を渡すと無音になる。
# volume は afplay に渡す倍率で、1.0 が原音、それより大きい値で増幅する。

set -euo pipefail

title=${1:?title is required}
subtitle=${2:-}
message=${3:-}
sound=${4:-Purr}
volume=${5:-2}

# 端末を見ている間に鳴らしても意味がないので、最前面が Ghostty なら何もしない。
# lsappinfo はアクセシビリティ権限を要求せずに最前面アプリを取得できる。
# NOTIFY_FORCE=1 を渡すと、端末を見たまま通知の見え方を確認できる。
if [ "${NOTIFY_FORCE:-}" != "1" ]; then
	front=$(lsappinfo info -only bundleid "$(lsappinfo front)" 2>/dev/null | cut -d '"' -f 4 || true)
	if [ "$front" = "com.mitchellh.ghostty" ]; then
		exit 0
	fi
fi

# AppleScript の文字列リテラルに埋め込むため、引用符とバックスラッシュを潰す。
# エージェントの発言をそのまま流すと、これらが混ざった時点で構文が壊れて通知が出なくなる。
escape() {
	printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
}

osascript -e "display notification \"$(escape "$message")\" with title \"$(escape "$title")\" subtitle \"$(escape "$subtitle")\""

# display notification の sound name には音量を指定する手段がないので、音は afplay で鳴らす。
sound_file="/System/Library/Sounds/${sound}.aiff"
if [ -f "$sound_file" ]; then
	afplay -v "$volume" "$sound_file"
fi
