{ pkgs, user, ... }: {
  system.stateVersion = 5;
  system.primaryUser = user.name;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  users.users."${user.name}" = {
    name = user.name;
    home = user.home;
  };

  # Determinate Systems Nix manages itself; disable nix-darwin's Nix management
  nix.enable = false;

  # GUI apps and Mac App Store via Homebrew (nix-darwin manages it declaratively)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    taps = [
      "nanobot-ai/tap"
      "nikitabobko/tap"
      "supabase/tap"
    ];
    brews = [
      "cocoapods"
      "duti"
      "httpd"
      "mysql"
      "postgresql@14"
      "qemu"
      "openjdk@21"
      "watchman"
      "nanobot-ai/tap/nanobot"
    ];
    casks = [
      "anki"
      "nikitabobko/tap/aerospace"
      "claude"
      "raycast"
      "discord"
      "docker"
      "google-chrome"
      "google-drive"
      "kicad"
      "kiro"
      "nani"
      "obsidian"
      "slack"
      "utm"
      "visual-studio-code"
      "wezterm"
      "windsurf"
      "zoom"
    ];
    masApps = {
      "Kindle"   = 302584613;
      "LINE"     = 539883307;
      "WhatsApp" = 310633997;
      # Xcode は手動インストール推奨（20GB超・互換性ダイアログ回避）
    };
  };

  # Keyboard / cursor / trackpad
  system.defaults.NSGlobalDomain = {
    KeyRepeat = 1;
    InitialKeyRepeat = 10;
    "com.apple.trackpad.scaling" = 3.0;
  };

  system.defaults.trackpad.Clicking = true;

  # Dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.tilesize = 40;

  # ホットコーナー（2=アプリウィンドウ, 4=なし, 14=クイックノート）
  system.defaults.dock.wvous-tl-corner = 2;
  system.defaults.dock.wvous-tr-corner = 2;
  system.defaults.dock.wvous-bl-corner = 4;
  system.defaults.dock.wvous-br-corner = 14;

  system.activationScripts.userDefaults.text = ''
    # 起動サウンドを無効化
    nvram StartupMute=%01
    # Spotlight の Cmd+Space を無効化（Raycast に譲る）
    sudo -u ${user.name} defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
    /System/Library/CoreServices/pbs -flush 2>/dev/null || true
    # マウスカーソル速度最速
    sudo -u ${user.name} defaults write NSGlobalDomain com.apple.mouse.scaling -float 3.0
    # Caps Lock で日本語/英字切り替え
    sudo -u ${user.name} defaults write com.apple.inputmethod.Kotoeri JIMPrefCapsLockDocModeKey -bool true
    # Kotoeri を再起動して設定を反映
    killall Kotoeri 2>/dev/null || true
    # ホットコーナーの修飾キー設定
    sudo -u ${user.name} defaults write com.apple.dock wvous-tl-modifier -int 0
    sudo -u ${user.name} defaults write com.apple.dock wvous-tr-modifier -int 0
    sudo -u ${user.name} defaults write com.apple.dock wvous-bl-modifier -int 0
    sudo -u ${user.name} defaults write com.apple.dock wvous-br-modifier -int 0
    # WezTerm をデフォルトターミナルに設定
    if [ -x /opt/homebrew/bin/duti ]; then
      sudo -u ${user.name} /opt/homebrew/bin/duti -s com.github.wez.wezterm com.apple.terminal.shell-script all
      sudo -u ${user.name} /opt/homebrew/bin/duti -s com.github.wez.wezterm public.shell-script all
    fi
  '';

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
