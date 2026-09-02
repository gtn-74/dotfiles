#!/usr/bin/env bash
# Claude Code ステータスライン: コンテキスト残量を HP ゲージ風に表示する。
# stdin に来る JSON から残量% を取り、██░░ バー + 色 (緑→黄→赤) で描画する。
# home-manager が ~/.claude/statusline.sh に配置し、settings.json の statusLine から呼ぶ。
input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')
# 残量%（早期セッションは null → 100 扱い）。切り捨てて整数化
rem=$(printf '%s' "$input" | jq -r '(.context_window.remaining_percentage // 100) | floor')

# バーの目盛り（20 セグメント）
segments=20
filled=$(( rem * segments / 100 ))
(( filled < 0 )) && filled=0
(( filled > segments )) && filled=segments
empty=$(( segments - filled ))

# 残量に応じた色: >50 緑 / >20 黄 / それ以下 赤
if   (( rem > 50 )); then color=$'\033[32m'
elif (( rem > 20 )); then color=$'\033[33m'
else                     color=$'\033[31m'
fi
reset=$'\033[0m'
dim=$'\033[2m'

bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty;  i++)); do bar+="░"; done

printf '%s %sHP%s %s%s%s %s%3d%%%s' \
  "$model" "$dim" "$reset" "$color" "$bar" "$reset" "$color" "$rem" "$reset"
