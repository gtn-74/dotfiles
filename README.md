# dotfiles

Home Manager (Nix) で管理する dotfiles リポジトリ。

## リポジトリ構成

```
dotfiles/
├── home/               # クロスプラットフォーム設定（Mac / Arch 共通）
│   ├── .zshenv
│   └── .config/
│       ├── nvim/       # Neovim
│       ├── zsh/        # Zsh
│       ├── fish/       # Fish
│       ├── wezterm/    # WezTerm
│       ├── git/        # Git
│       ├── gh/         # GitHub CLI
│       ├── mise/       # mise (ランタイム管理)
│       └── sheldon/    # Zsh プラグインマネージャー
└── arch/               # Arch Linux 固有設定
    ├── home.nix        # Home Manager 設定ファイル
    └── .config/
        └── hypr/
            └── custom/ # Hyprland ユーザーカスタマイズ
                ├── env.conf
                ├── execs.conf
                ├── general.conf
                ├── keybinds.conf
                └── rules.conf
```

> **dots-hyprland 本体**（`hyprland/` フォルダ等）は Home Manager では管理しない。
> 新PC時に setup スクリプトを1回実行する。

---

## Arch Linux (Hyprland) 新規セットアップ

### 1. Nix インストール

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### 2. Home Manager インストール

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### 3. dotfiles クローン

```bash
git clone https://github.com/gtn-74/dotfiles.git ~/dotfiles
```

### 4. Home Manager の設定をリンク

```bash
ln -sf ~/dotfiles/arch/home.nix ~/.config/home-manager/home.nix
```

### 5. パッケージ・設定を適用

```bash
home-manager switch
```

これだけで以下が全て適用される：
- Hyprland 関連パッケージ（waybar, hypridle, mako 等）
- 開発ツール（nvim, wezterm, gh, mise 等）
- `~/.config/hypr/custom/` のカスタマイズ設定（シンボリックリンク）
- zsh / fish / nvim 等の設定ファイル

### 6. dots-hyprland のセットアップ（1回だけ）

Hyprland の UI テーマ・シェル部分は dots-hyprland で管理している：

```bash
git clone https://github.com/end-4/dots-hyprland.git ~/dots-hyprland
cd ~/dots-hyprland
./setup
```

> home-manager switch でリンクした `~/.config/hypr/custom/` は dots-hyprland setup 後も上書きされない。

---

## Mac 新規セットアップ

### 1. Homebrew インストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. dotfiles クローン

```bash
git clone https://github.com/gtn-74/dotfiles.git ~/dotfiles
```

### 3. GNU Stow でリンク

```bash
brew install stow
cd ~/dotfiles
stow home
```

### 4. Brewfile から一括インストール

```bash
brew bundle --file ~/.config/Brewfile
```

> VSCode は Settings Sync で同期。

---

## 日常的な使い方

### 設定を変更する

設定ファイルはシンボリックリンクなので、`~/.config/` 上で直接編集すると dotfiles リポジトリに即反映される。

ただし `hypr/custom/` は nix store への読み取り専用リンクのため、**dotfiles 側を編集してから** `home-manager switch` が必要：

```bash
# 例: キーバインドを変更したい場合
vim ~/dotfiles/arch/.config/hypr/custom/keybinds.conf
home-manager switch
```

### 新しい設定を追加する（Arch）

例：`~/.config/foo/` を管理対象にしたい場合：

```bash
# 1. dotfiles にコピー
cp -r ~/.config/foo ~/dotfiles/arch/.config/

# 2. home.nix に追記
#    home.file.".config/foo".source = ./.config/foo;

# 3. 適用
home-manager switch
```

### パッケージを追加する

`arch/home.nix` の `home.packages` にパッケージ名を追記して：

```bash
home-manager switch
```
