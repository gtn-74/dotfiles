
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# oh-my-zsh のパスを設定
export ZSH="$HOME/.oh-my-zsh"
# テーマを設定
ZSH_THEME="jonathan"

# oh-my-zsh を読み込む
source $ZSH/oh-my-zsh.sh

# Kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# zoxide
eval "$(zoxide init zsh)"

# the root path of the Git repository
# git alias
alias cdroot='cd "$(git rev-parse --show-toplevel)"'
alias gsw='git switch'
alias gcb='git switch -C'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gb='git branch'
alias gal='alias | grep 'git' | grep -v 'gal=''

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
