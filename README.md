# dotfiles

nix-darwin + Home Manager (Nix) で管理する dotfiles リポジトリ。Mac / Arch Linux に対応。

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
│       ├── sheldon/    # Zsh プラグインマネージャー
│       └── jj/         # Jujutsu
├── mac/                # macOS 固有設定（nix-darwin）
│   ├── flake.nix       # flake 定義・ユーザー設定
│   ├── darwin.nix      # システム設定・Homebrew casks
│   └── home.nix        # Home Manager パッケージ
└── arch/               # Arch Linux 固有設定
    ├── home.nix        # Home Manager 設定ファイル
    └── .config/
        └── hypr/
            └── custom/ # Hyprland ユーザーカスタマイズ
```

---

## Mac 新規セットアップ

### 1. Nix インストール（Determinate Systems）

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

インストール後、新しいターミナルを開くか以下を実行：

```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

### 2. dotfiles クローン

```bash
git clone https://github.com/gtn-74/dotfiles.git ~/dotfiles
```

### 3. GNU Stow で設定ファイルをリンク

```bash
brew install stow
cd ~/dotfiles && stow home
```

### 4. ユーザー設定を編集

`mac/flake.nix` の `let user = { ... }` ブロックを自分の環境に合わせて変更：

```nix
let
  user = {
    name     = "your-username";
    home     = "/Users/your-username";
    hostname = "your-hostname";  # scutil --get LocalHostName で確認
  };
```

### 5. nix-darwin を適用（初回のみ）

```bash
cd ~/dotfiles && git add mac/
sudo /nix/var/nix/profiles/default/bin/nix run \
  'github:LnL7/nix-darwin/8c62fba0854ba15c8917aed18894dbccb48a3777' \
  -- switch --flake ~/dotfiles/mac#<hostname>
```

> 開発ツール・言語ランタイム（node / go / deno / uv / pnpm / yarn / java など）は
> `mac/dev-tools.nix` で nix 管理しているため、`darwin-rebuild switch` で一緒に入る。
> 個別インストール手順は不要。

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

### 6. dots-hyprland のセットアップ（1回だけ）

```bash
git clone https://github.com/end-4/dots-hyprland.git ~/dots-hyprland
cd ~/dots-hyprland && ./setup
```

---

## 日常的な使い方

### 設定変更を適用する

```bash
# Mac
sudo darwin-rebuild switch --flake ~/dotfiles/mac#<hostname>

# Arch
home-manager switch
```

### 設定ファイルを編集する

`home/` 以下はシンボリックリンクなので `~/.config/` 上で直接編集すると dotfiles に即反映される。

### パッケージを追加する（Mac）

`mac/home.nix` の `home.packages` に追記して `darwin-rebuild switch`。

GUI アプリは `mac/darwin.nix` の `homebrew.casks` に追記。

### パッケージを追加する（Arch）

`arch/home.nix` の `home.packages` に追記して `home-manager switch`。
