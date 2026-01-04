# Bootstrap file to set ZDOTDIR
# This tells zsh to load configs from ~/.config/zsh/
export ZDOTDIR="$HOME/.config/zsh"

# Source the actual .zshenv from .config/zsh if it exists
[ -f "$ZDOTDIR/.zshenv" ] && source "$ZDOTDIR/.zshenv"
