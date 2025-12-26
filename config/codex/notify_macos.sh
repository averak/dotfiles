#!/bin/bash

# JSONから最後のエージェント発言を抽出
LAST_MESSAGE=$(echo "$1" | jq -r '.["last-assistant-message"] // "Codex task completed"')

# sound name を追加することで、通知と一緒にシステム音が鳴ります
osascript -e "display notification \"$LAST_MESSAGE\" with title \"Codex\" sound name \"Default\""
