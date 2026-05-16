{ pkgs, user, ... }: {
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
    git
    gh
    jujutsu
    neovim
    mise
    ripgrep
    fd
    jq
    cloc
    hugo
    pipx
    stow

    # Misc
    mas
    wget
  ];

  programs.home-manager.enable = true;
}
