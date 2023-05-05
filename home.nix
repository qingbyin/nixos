# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, user, lib, ... }:

{

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  imports = [
    # ./modules/emacs/emacs.nix
    ./modules/common/zsh.nix
    # ./modules/kitty/kitty.nix
    ./modules/vscode/vscode.nix
    ./modules/neovim/neovim.nix
    ./modules/i3/i3-home.nix
    ./modules/fcitx5/fcitx5-home.nix
    ./modules/chrome/chrome.nix
  ];

  # Install packages with plugins and configs
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # OpenGL
    # nixgl.auto.nixGLDefault # Auto-detect and install OpenGL based the hardware, e.g. nvidia or amd
    # glxinfo
    # vulkan-tools
    # glmark2

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
    gnupg
    xcape

    # Terminal
    btop              # Resource Manager
    nitch             # Minimal fetch (faster than screenfetch)
    ranger            # File Manager
    tldr              # Helper (simplified man pages)
    fd
    ripgrep
    ripgrep-all

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
    #goldendict
    uget # download manager
    peek # gif screen recorder
    anki-bin

    # lazy
    lazydocker
    lazygit

    # File Management
    gnome.file-roller # Archive Manager GUI
    okular            # PDF Viewer
    pcmanfm           # File Manager GUI
    rsync             # Syncer - $ rsync -r dir1/ dir2/
    unzip
    unrar
    zip
    p7zip
  ];

  # Configure keymap in X11
  services.xcape = {
    enable = true;
    mapExpression = { Caps_Lock = "Control_L";};
  };

  programs.git = {
    enable = true;
    userName  = "Qing Yin";
    userEmail = "qingbyin@gmail.com";
  };

  programs.gpg.enable = true;

  # Network manager tray icon
  # services.network-manager-applet.enable = true;
  # Bluetooth
  # services.blueman-applet.enable = true;
  # Battery
  services.cbatticon  = {
    enable = true;
    criticalLevelPercent = 10;
    commandCriticalLevel = ''notify-send "battery critical!"'';
    lowLevelPercent = 30;
    iconType = "standard";
  };

  # Auto mount usb
  services.udiskie.enable = true;
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
