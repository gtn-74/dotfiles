# Bootstrap file to set ZDOTDIR
# This tells zsh to load configs from ~/.config/zsh/
export ZDOTDIR="$HOME/.config/zsh"

# TTY1でfbterm（日本語対応ターミナル）を自動起動
# $FBTERM が設定済みの場合は二重起動を防ぐ
if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ] && [ -z "$FBTERM" ] && command -v fbterm >/dev/null 2>&1; then
  exec uim-fep -e fbterm
fi

# Source the actual .zshenv from .config/zsh if it exists
[ -f "$ZDOTDIR/.zshenv" ] && source "$ZDOTDIR/.zshenv"
