{ config, pkgs, ... }:

{
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
    hyprlock
    hyprlauncher
    mako            # notifications
    grim            # screenshots
    slurp           # region select for screenshots
    wl-clipboard    # clipboard

    # Media / brightness (used in hyprland keybindings)
    playerctl
    brightnessctl

    # CLI tools
    ripgrep
    fd
    jq
    eza
    bat
    fzf
    mise
    gh
    jujutsu
  ];

  # ============================================================
  # Arch-specific configs
  # ============================================================
  home.file.".config/hypr/hyprland.conf".source = ./.config/hypr/hyprland.conf;
  home.file.".config/kitty.conf".source = ./.config/kitty.conf;

  # ============================================================
  # Shared configs (from home/ in the dotfiles repo)
  # ============================================================
  home.file.".config/nvim".source = ../home/.config/nvim;
  home.file.".config/git".source = ../home/.config/git;
  home.file.".config/zsh".source = ../home/.config/zsh;
  home.file.".config/fish".source = ../home/.config/fish;
  home.file.".config/wezterm".source = ../home/.config/wezterm;
  home.file.".config/sheldon".source = ../home/.config/sheldon;
  home.file.".config/mise".source = ../home/.config/mise;
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

  programs.home-manager.enable = true;
}
