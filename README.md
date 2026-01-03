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
- **wezterm**: WezTerm ターミナルの設定
- **brew**: Homebrew パッケージリスト（Brewfile）

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
stow bash git zsh nvim fish gh karabiner mise wezterm brew

# または個別に配置
stow bash    # Bash 設定のみ
stow git     # Git 設定のみ
stow wezterm # WezTerm 設定のみ
stow brew    # Brewfile のみ
# など...
```

### 5. Brewfile から一括インストール

```bash
brew bundle  # ~/Brewfile（stow でリンク済み）から読み込み
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

### 新しい設定ファイル・ディレクトリの追加

例：新しく作成した `~/.config/alacritty` を dotfiles に追加する場合

```bash
cd ~/dotfiles

# 1. dotfiles 内にディレクトリ構造を作成してコピー
mkdir -p alacritty/.config
cp -r ~/.config/alacritty alacritty/.config/

# 2. 元のファイルを削除
rm -rf ~/.config/alacritty

# 3. stow でシンボリックリンクを作成
stow alacritty

# 4. Git に追加
git add alacritty
git commit -m "Add alacritty config"
```

**重要**: `~/dotfiles/パッケージ名/` 以下の構造が、そのまま `~` に展開されます。
- `~/.config/xxx` を管理する場合 → `~/dotfiles/パッケージ名/.config/xxx/` という構造にする
- `~/xxx` を管理する場合 → `~/dotfiles/パッケージ名/xxx` という構造にする

### Brewfile に追記（手動または dump）

```bash
brew bundle dump --force  # 既存の ~/Brewfile を上書き
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

```zsh
brew install mas
```

- brew install --cask utm
- brew install --cask slack
- brew install --cask zoom
- brew install --cask visual-studio-code
- brew install --cask google-drive
- brew install --cask nani
- brew install --cask anki
- brew install --cask claude
- brew install --cask antigravity
- brew install --cask windsurf
- brew install --cask obsidian
- brew install --cask clipy
- brew install --cask discord
- brew install docker
- brew install --cask google-chrome
- brew install --cask kicad
- brew install --cask virtualbox
- brew install --cask wezterm
