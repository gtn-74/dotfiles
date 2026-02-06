
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# sheldon (plugin manager)
eval "$(sheldon source)"

# Kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# the root path of the Git repository
# git alias
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

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

