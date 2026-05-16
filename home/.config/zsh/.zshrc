# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# Disable p10k instant prompt to avoid gitstatus initialization errors
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# sheldon (plugin manager)
command -v sheldon &>/dev/null && eval "$(sheldon source)"

# fzf shell integration
command -v fzf &>/dev/null && eval "$(fzf --zsh)"

# zoxide (j で移動)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd j)"

# fzf の Ctrl+T (ファイル検索) を無効化 - WezTerm のタブ新規作成と競合するため
bindkey -r '^T'

# Kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# the root path of the Git repository
# git alias
alias clear='paclear -s 10'
alias cdroot='cd "$(git rev-parse --show-toplevel)"'
alias gsw='git switch'
alias gcb='git switch -C'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gb='git branch'
alias gal='alias | grep "^g"'
cmal() {
  echo "=== aliases ==="
  alias | grep -v "^g"
  echo "\n=== functions ==="
  echo "cdf: Search all directories (fd + fzf)"
}

# directory search (fd + fzf)
cdf() {
  local dir
  dir=$(fd --type d | fzf) && cd "$dir"
}
# fzf
# .bashrcや.zshrcに追加
alias fv='fzf --preview "bat --color=always {}" --preview-window right:60%'

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

true
