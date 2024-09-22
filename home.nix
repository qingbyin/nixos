# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, ... }:

let
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
in
{

  home = {
    username = "qyin";
    homeDirectory = "/home/qyin";
  };

  # Modify environment setings to make nix compatiable with distro like Ubuntu
  targets.genericLinux.enable = true;
  # Default application dir for nix
  xdg.mime.enable = true;
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true; # create .config/mimeapps.list
    defaultApplications = {
      "text/html" = "brave.desktop";
      "x-scheme-handler/http" = "brave.desktop";
      "x-scheme-handler/https" = "brave.desktop";
      "application/pdf" = "okular.desktop";
      "image/jpeg" = "feh.desktop";
      "video/mp4" = "vlc.desktop";
      "text/plain" = "nvim.desktop";
      "application/excel" = "wps-office-et.desktop";
      "application/msexcel" = "wps-office-et.desktop";
      "application/msword" = "wps-office-wpp.desktop";
      "application/mspowerpoint" = "wps-office-wpp.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      = "wps-office-wpp.desktop";
    };
  };

  imports = [
    ./modules/fonts/fonts.nix
    # ./modules/emacs/emacs.nix
    ./modules/common/zsh.nix
    ./modules/alacritty/alacritty.nix
    # ./modules/kitty/kitty.nix
    ./modules/vscode/vscode.nix
    ./modules/neovim/neovim.nix
    ./modules/i3/i3-home.nix
    ./modules/fcitx5/fcitx5-home.nix
    ./modules/chrome/chrome.nix
  ];

  # Install packages with plugins and configs
  home.packages = with pkgs; [
    # OpenGL
  # nixGL.auto.nixGLDefault # Auto-detect and install OpenGL based the hardware, e.g. nvidia or amd
    # glxinfo
    # vulkan-tools
    # glmark2
    nix-query-tree-viewer
    nodejs_22

    vim
    wget
    usbutils # lsusb
    pciutils # lspci
    xdg-utils
    gnupg
    xcape
    xclip

    # Terminal
    tmux
    btop              # Resource Manager
    nitch             # Minimal fetch (faster than screenfetch)
    ranger            # File Manager
    tldr              # Helper (simplified man pages)
    fd
    ripgrep
    ripgrep-all
    cloc # count code lines
    imagemagick # include commands like "convert"
    pandoc

    # Video/Audio
    mpv               # Media Player
    pavucontrol       # Audio Control
    plex-media-player # Media Player
    vlc               # Media Player
    ffmpeg
    stremio           # Media Streamer
    blueberry # bluetooth config tool

    # Apps
    appimage-run      # Runs AppImages on NixOS
    # onlyoffice-bin    # Office
    nur.repos.rewine.wps
    libreoffice
    # vmware-workstation
    ventoy # bootable usb ISO installer

    rclone
    flameshot         # Screenshot
    #goldendict
    uget # download manager
    # (pkgs.callPackage ./modules/common/fdm.nix {})
    yt-dlp # video download CLI (e.g. youtube, bilibili)
    peek # gif screen recorder
    #anki-bin
    qq
    wechat-uos
    keeweb # password manager
    zotero
    freerdp # remote desktop
    drawio
    inkscape-with-extensions
    livecaptions
    graphviz # graph drawing
    # need to run with "nixgl"
    # obs-studio # mirror a window to the external display/monitor

    # lazy
    lazydocker
    lazygit

    # File Management
    file-roller # Archive Manager GUI
    okular            # PDF Viewer
    pcmanfm           # File Manager GUI
    rsync             # Syncer - $ rsync -r dir1/ dir2/
    unzrip # 新版 unzip解决中文乱码：unzip -O cp936
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
  home.stateVersion = "23.11";
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
