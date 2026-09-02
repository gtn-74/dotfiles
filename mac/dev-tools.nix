{ pkgs, ... }:
# 旧 mise (~/.config/mise/config.toml) で管理していた開発ツールを nix に一本化。
# バージョンは flake.lock で固定され、`nix flake update` で追従する。
# プロジェクト単位のバージョン切替は行わない前提（mise 廃止）。
let
  # nixpkgs に無い Go 製ツールはソースからビルドする。
  # もとは mise の `go:github.com/orangekame3/paclear = "latest"`。
  # 更新時: version を上げ、hash / vendorHash はビルド時のエラーメッセージで得た値に差し替える。
  paclear = pkgs.buildGoModule rec {
    pname = "paclear";
    version = "0.0.13";
    src = pkgs.fetchFromGitHub {
      owner = "orangekame3";
      repo = "paclear";
      rev = "v${version}";
      hash = "sha256-Q4uY5aEcQKKLxhBGzmLdOy/bLG0/hpFRkF10wA68Ic0=";
    };
    vendorHash = "sha256-VE3nnUO3A/HkaoGXef+zuPT2VubWiDfiiSils0F0l74=";
  };
in
{
  home.packages = with pkgs; [
    # 言語ランタイム
    deno
    go
    jdk21          # 旧 java = "21"（OpenJDK 21）
    nodejs_latest  # 旧 node = "latest"。安定版に寄せるなら nodejs_22 に変更

    # JS パッケージマネージャ
    pnpm
    yarn-berry     # 旧 yarn = "latest"（実体は Yarn 4.x Berry。anki 用）

    # Python
    uv

    # CLI ツール
    lazygit
    shfmt

    # AI CLI（旧 npm グローバル）
    claude-code    # 旧 npm:@anthropic-ai/claude-code
    gemini-cli     # 旧 npm:@google/gemini-cli

    # Go 製ツール（上でビルド）
    paclear
  ];
}
