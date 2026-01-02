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