# dotfiles

GNU Stow を使用した dotfiles 管理リポジトリ

## XDG Base Directory とは？

**仕様（ルール・規格）**の名前です。ライブラリやソフトウェアではありません。

### 従来の方法 vs XDG準拠

**昔の方法**:
```
~/
├── .bashrc
├── .vimrc
├── .gitconfig
├── .zshrc
└── .npmrc  # ホームディレクトリがドットファイルだらけ😫
```

**XDG準拠の方法**:
```
~/
├── .bashrc（最小限のブートストラップ）
└── .config/        # ← ここにまとめる！
    ├── bash/
    ├── git/
    ├── nvim/
    └── zsh/        # スッキリ整理✨
```

### このリポジトリのアプローチ

設定ファイルを `~/.config/` 配下に集約することで：
- ✅ ホームディレクトリが散らからない
- ✅ 設定の場所が分かりやすい
- ✅ バックアップ・管理が簡単

詳細: [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

## 含まれる設定

**home** パッケージに全設定を統合管理（XDG Base Directory 準拠）:

- **Shell 設定**:
  - Bash: `~/.config/bash/`
  - Zsh: `~/.config/zsh/`（ZDOTDIR で指定）
  - Fish: `~/.config/fish/`
- **開発ツール**:
  - Git: `~/.config/git/`
  - GitHub CLI: `~/.config/gh/`
  - mise: `~/.config/mise/`
- **エディタ・ターミナル**:
  - Neovim: `~/.config/nvim/`([詳細](home/.config/nvim/README.md))
  - WezTerm: `~/.config/wezterm/`（[詳細](home/.config/wezterm/README.md)）
  - Sheldon: `~/.config/sheldon/`（[詳細](home/.config/sheldon/README.md)） - zsh プラグインマネージャー
- **その他**:
  - Karabiner-Elements: `~/.config/karabiner/`
  - Brewfile: `~/.config/Brewfile`

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
# すべての設定をシンボリックリンク（1コマンドで完了）
stow home
```

これだけで以下がリンクされます:
- `~/.bashrc` → ブートストラップファイル（`~/.config/bash/bashrc` を読み込む）
- `~/.zshenv` → ブートストラップファイル（`ZDOTDIR=~/.config/zsh` を設定）
- `~/.config/` 配下のすべての設定ファイル

### 5. Brewfile から一括インストール

```bash
brew bundle --file ~/.config/Brewfile  # stow でリンク済み
```

すべてのアプリ・ツールが復元される！

## 日常的な使い方

### 設定ファイルの編集

stow でリンクされた設定ファイルを編集すると、自動的に dotfiles リポジトリに反映されます：

```bash
# XDG 準拠の設定ファイルを編集
vim ~/.config/zsh/.zshrc  # ~/dotfiles/home/.config/zsh/.zshrc を編集
vim ~/.config/nvim/init.lua  # ~/dotfiles/home/.config/nvim/init.lua を編集

cd ~/dotfiles
git add -A
git commit -m "Update configuration"
```

### 新しい設定ファイル・ディレクトリの追加

例：新しく作成した `~/.config/alacritty` を dotfiles に追加する場合

```bash
cd ~/dotfiles

# 1. home/.config 内にコピー
cp -r ~/.config/alacritty home/.config/

# 2. 元のファイルを削除
rm -rf ~/.config/alacritty

# 3. stow で再リンク（home パッケージ全体を再stow）
stow -R home

# 4. Git に追加
git add home/.config/alacritty
git commit -m "Add alacritty config"
```

**重要**:
- すべての設定は `~/dotfiles/home/` に統合管理（XDG Base Directory 準拠）
- `.config` 配下の設定は `~/dotfiles/home/.config/` に配置
- Shell のブートストラップファイル（.bashrc, .zshenv）は `~/dotfiles/home/` 直下

### Brewfile に追記（手動または dump）

```bash
brew bundle dump --force --file ~/.config/Brewfile  # 既存の Brewfile を上書き
```

### 設定の削除

```bash
cd ~/dotfiles
stow -D home  # すべての設定のリンクを削除
```

## GNU Stow の仕組み

`~/dotfiles/home/` 内のファイルを `~` にシンボリックリンクとして展開：

**ブートストラップファイル**:
- `~/dotfiles/home/.bashrc` → `~/.bashrc`（`~/.config/bash/bashrc` を読み込む）
- `~/dotfiles/home/.zshenv` → `~/.zshenv`（`ZDOTDIR=~/.config/zsh` を設定）

**設定ファイル（XDG 準拠）**:
- `~/dotfiles/home/.config/bash/` → `~/.config/bash/`
- `~/dotfiles/home/.config/git/` → `~/.config/git/`
- `~/dotfiles/home/.config/zsh/` → `~/.config/zsh/`
- `~/dotfiles/home/.config/nvim/` → `~/.config/nvim/`
- `~/dotfiles/home/.config/wezterm/` → `~/.config/wezterm/`
- `~/dotfiles/home/.config/mise/` → `~/.config/mise/`
- その他すべての `.config` 配下のツール

**ディレクトリ構造**:
```
dotfiles/
└── home/              # すべての設定を統合管理
    ├── .bashrc        # Bash ブートストラップ
    ├── .zshenv        # Zsh ブートストラップ（ZDOTDIR 設定）
    └── .config/       # XDG Base Directory 準拠
        ├── bash/      # Bash 設定
        │   └── bashrc
        ├── git/       # Git 設定
        │   └── config
        ├── zsh/       # Zsh 設定
        │   ├── .zshrc
        │   └── .zshenv
        ├── nvim/      # Neovim 設定
        ├── wezterm/   # WezTerm 設定
        ├── mise/      # mise 設定
        ├── gh/        # GitHub CLI 設定
        ├── fish/      # Fish シェル設定
        ├── karabiner/ # Karabiner 設定
        └── Brewfile   # Homebrew パッケージリスト
```

**参考リポジトリと同様の構造**を実現しつつ、GNU Stow で管理できる形になっています。

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
