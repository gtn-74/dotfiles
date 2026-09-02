{ config, pkgs, ... }:

{
  imports = [ ../mac/dev-tools.nix ]; # 旧 mise 管理の開発ツール群（mac と共有）

  nixpkgs.config.allowUnfree = true;

  # non-NixOS での GPU サポート
  targets.genericLinux.enable = true;

  home.username = "gtn-74";
  home.homeDirectory = "/home/gtn-74";
  home.stateVersion = "25.11";

  # ============================================================
  # Packages
  # ============================================================
  home.packages = with pkgs; [
    # Hyprland ecosystem
    waybar
    hyprpaper
    hypridle
    hyprlauncher
    mako            # notifications
    grim            # screenshots
    slurp           # region select for screenshots
    wl-clipboard    # clipboard

    # Media / brightness (used in hyprland keybindings)
    playerctl
    brightnessctl

    # Apps
    slack
    wezterm
    nautilus
    gnome-control-center
    nwg-dock-hyprland

    # Fonts
    nerd-fonts.jetbrains-mono

    # CLI tools
    ni
    ripgrep
    fd
    jq
    eza
    bat
    fzf
    gh
    jujutsu
    sheldon
  ];

  # ============================================================
  # Arch-specific configs
  # ============================================================
  # dots-hyprland本体は新PC時に setup スクリプトを1回実行する
  # ユーザーカスタマイズ部分だけをここで管理する
  home.file.".config/hypr/custom".source = ./.config/hypr/custom;

  # ============================================================
  # Shared configs (from home/ in the dotfiles repo)
  # ============================================================
  home.file.".config/nvim".source = ../home/.config/nvim;
  home.file.".config/git".source = ../home/.config/git;
  home.file.".config/zsh".source = ../home/.config/zsh;
  home.file.".config/fish".source = ../home/.config/fish;
  home.file.".config/wezterm".source = ../home/.config/wezterm;
  home.file.".config/sheldon".source = ../home/.config/sheldon;
  home.file.".config/gh".source = ../home/.config/gh;

  # ============================================================
  # Shell
  # ============================================================
  home.file.".zshenv".source = ../home/.zshenv;

  # ============================================================
  # Environment variables
  # ============================================================
  home.sessionVariables = {
    EDITOR = "nvim";
    # Wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # XDG
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.home-manager.enable = true;
}
