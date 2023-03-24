# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, user, ... }: {

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  imports = [
    # ./modules/emacs/emacs.nix
    ./modules/i3/i3-home.nix
    ./modules/fcitx5/fcitx5-home.nix
  ];

  # Install packages with plugins and configs
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # Fonts
    source-han-sans
    source-han-serif
    wqy_microhei
    source-code-pro
    jetbrains-mono
    font-awesome 
    corefonts # MS (e.g. Time New Roman)
    (nerdfonts.override { fonts = [ "FiraCode" ]; })# Nerdfont Icons override

    vim
    wget
    usbutils # lsusb
    pciutils # lspci
    xdg-utils
    # OpenGL
    glxinfo
    vulkan-tools
    glmark2

    # Terminal
    btop              # Resource Manager
    nitch             # Minimal fetch (faster than screenfetch)
    ranger            # File Manager
    tldr              # Helper (simplified man pages)

    # Video/Audio
    mpv               # Media Player
    pavucontrol       # Audio Control
    plex-media-player # Media Player
    vlc               # Media Player
    stremio           # Media Streamer

    # Apps
    appimage-run      # Runs AppImages on NixOS
    onlyoffice-bin    # Office
    rclone
    flameshot         # Screenshot
    goldendict

    # File Management
    gnome.file-roller # Archive Manager GUI
    okular            # PDF Viewer
    pcmanfm           # File Manager GUI
    rsync             # Syncer - $ rsync -r dir1/ dir2/
    unzip             # Zip Files
    unrar             # Rar Files
    zip               # Zip
  ];

  # Configure keymap in X11
  services.xcape = {
    enable = true;
    mapExpression = { Caps_Lock = "Control_L";};
  };

  # Terminal
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 12;
    theme = "Oceanic Material";
    settings = {
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = 2;
      confirm_os_window_close = 0;
      shell = "zsh";
    };
    keybindings = {
      "ctrl+shift+s" = "set_tab_title";
    };
  };

  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };

  programs.git = {
    enable = true;
    userName  = "Qing Yin";
    userEmail = "qingbyin@gmail.com";
  };

  programs.gpg.enable = true;

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome; 
    extensions = [
      "padekgcemlokbadohgkifijomclgjgif" # SwitchyOmega
    ];
  };

  # Network manager tray icon
  # services.network-manager-applet.enable = true;
  # Bluetooth
  # services.blueman-applet.enable = true;
  # Battery
  # services.cbatticon  = {
  #   enable = true;
  #   criticalLevelPercent = 10;
  #   commandCriticalLevel = ''notify-send "battery critical!"'';
  #   lowLevelPercent = 30;
  #   iconType = "standard";
  # };

  # Auto mount usb
  # services.udiskie.enable = true;
  # Auto hide cursor
  services.unclutter.enable = true; # Auto hide cursor

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Set the minimum required home-manager version
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
