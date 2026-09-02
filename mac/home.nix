{ pkgs, lib, user, ... }: {
  imports = [ ./dev-tools.nix ]; # 旧 mise 管理の開発ツール群

  home.username = user.name;
  home.homeDirectory = user.home;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # Shell
    bash-completion
    fzf
    sheldon
    zoxide

    # Dev tools
    ni
    git
    gh
    jujutsu
    neovim
    ripgrep
    fd
    jq
    cloc
    hugo
    pipx
    stow

    # Docker (Docker Desktop 非依存の daemon)
    # colima = Lima の軽量 Linux VM 上で dockerd を動かす。`colima start` で
    # docker context "colima" が立ち、Docker Desktop を起動せず lazydocker が使える。
    # docker / docker-compose CLI は Docker Desktop の既存物を context 切替で流用。
    colima
    lazydocker

    # Misc
    mas
    wget
  ];

  programs.home-manager.enable = true;

  # Claude Code のコンテキスト残量を HP ゲージ風に出すステータスライン。
  # スクリプトは ~/.claude/statusline.sh に配置し、settings.json には
  # statusLine キーだけを冪等マージする（model/theme など Claude Code 自身が
  # /config で書き換えるキーは触らないため、settings.json 全体は nix 管理しない）。
  home.file.".claude/statusline.sh" = {
    source = ./statusline.sh;
    executable = true;
  };

  home.activation.claudeStatusLine =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      cfg="${user.home}/.claude/settings.json"
      run mkdir -p "$(dirname "$cfg")"
      [ -f "$cfg" ] || echo '{}' > "$cfg"
      run ${pkgs.jq}/bin/jq \
        --arg cmd "${user.home}/.claude/statusline.sh" \
        '.statusLine = { type: "command", command: $cmd }' \
        "$cfg" > "$cfg.tmp" && run mv "$cfg.tmp" "$cfg"
    '';
}
