# dotfiles

GNU Stow を使用した dotfiles 管理リポジトリ

## 含まれる設定

- **bash**: Bash シェルの設定（.bashrc）
- **git**: Git の設定（.gitconfig と .config/git）
- **zsh**: Zsh シェルの設定（.zshrc, .zshenv）
- **nvim**: Neovim エディタの設定
- **fish**: Fish シェルの設定
- **gh**: GitHub CLI の設定
- **karabiner**: Karabiner-Elements の設定
- **mise**: Mise（ランタイムバージョンマネージャー）の設定
- **Brewfile**: Homebrew パッケージリスト

## 新しい Mac でのセットアップ

### vscode は Settings Sync で同期

### 1. Homebrew インストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. GNU Stow インストール

```bash
brew install stow
```

### 3. dotfiles クローン

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 4. 設定ファイルをシンボリックリンク

```bash
# 必要な設定をシンボリックリンク
stow bash git zsh nvim fish gh karabiner mise

# または個別に配置
stow bash    # Bash 設定のみ
stow git     # Git 設定のみ
# など...
```

### 5. Brewfile から一括インストール

```bash
brew bundle --file ~/dotfiles/Brewfile
```

すべてのアプリ・ツールが復元される！

## 日常的な使い方

### 設定ファイルの編集

stow でリンクされた設定ファイルを編集すると、自動的に dotfiles リポジトリに反映されます：

```bash
vim ~/.bashrc  # ~/dotfiles/bash/.bashrc を編集
cd ~/dotfiles
git add -A
git commit -m "Update configuration"
```

### Brewfile に追記（手動または dump）

```bash
brew bundle dump --force --file ~/dotfiles/Brewfile  # 既存の Brewfile を上書き
```

### 設定の削除

```bash
cd ~/dotfiles
stow -D bash  # bash 設定のリンクを削除
```

## GNU Stow の仕組み,

`~/dotfiles/パッケージ名/` 内のファイルを `~` にシンボリックリンクとして展開：

- `~/dotfiles/bash/.bashrc` → `~/.bashrc`
- `~/dotfiles/git/.gitconfig` → `~/.gitconfig`
- `~/dotfiles/nvim/.config/nvim/` → `~/.config/nvim/`

## 参考

- [GNU Stow 公式サイト](https://www.gnu.org/software/stow/)
- [Brewfile で Homebrew のライブラリを管理しよう！](https://kakakakakku.hatenablog.com/entry/2020/09/17/124653)
