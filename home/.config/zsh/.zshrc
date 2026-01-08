
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# zsh plugins
plugins=(
    zsh-autosuggestions
)

# 便利なエイリアス
alias ..='cd ..'
alias _='cd -'
alias ls='ls -hF -G'
alias ll='ls -l -h'
alias la='ls -lA'
alias du='du -kh'
alias df='df -kTh'


# Kiro
export PATH="$HOME/.local/bin:$PATH"
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# mise（すべてのツールの PATH 管理）
eval "$(mise activate zsh)"

# zoxide
eval "$(zoxide init zsh)"

# the root path of the Git repository
# git alias
alias cdroot='cd "$(git rev-parse --show-toplevel)"'
alias gsw= switch
alias gcb = switch -C
alias gsp = stash pop
alias gsl = stash list
alias gb = branch
alias gal='git config --get-regexp alias'

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"