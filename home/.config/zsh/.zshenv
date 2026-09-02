# .zshenv - すべてのzshセッションで読み込まれる

export EDITOR=nvim

# Homebrew（Intel Mac の場合は /usr/local/bin）
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Kiro
export PATH="$HOME/.local/bin:$PATH"

# direnv（flake を持つプロジェクトでは nix の言語を優先させる）
# nix profile に入れた direnv を使う
export PATH="$HOME/.nix-profile/bin:$PATH"
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# JAVA_HOME
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home

# Cargo
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
