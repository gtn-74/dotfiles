# .zshenv - すべてのzshセッションで読み込まれる

# Homebrew（Intel Mac の場合は /usr/local/bin）
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Kiro
export PATH="$HOME/.local/bin:$PATH"

# mise（すべてのツールの PATH 管理）
eval "$(mise activate zsh)"

# JAVA_HOME
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home

# Cargo
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
