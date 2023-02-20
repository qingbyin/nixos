# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, user, ... }: {

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  imports = [
    # Split up configuration and import pieces of it here:
    # ./modules/emacs/emacs.nix
    ./modules/sway/sway.nix
    ./modules/fcitx5/fcitx5.nix
  ];

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
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

    # File Management
    gnome.file-roller # Archive Manager GUI
    okular            # PDF Viewer
    pcmanfm           # File Manager GUI
    rsync             # Syncer - $ rsync -r dir1/ dir2/
    unzip             # Zip Files
    unrar             # Rar Files
    zip               # Zip
  ];

  # Install packages with plugins and configs

  # Terminal
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "FiraCode Nerd Font Mono:size=12, WenQuanYi Micro Hei:size=12";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
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
  services.network-manager-applet.enable = true;
  # Bluetooth
  services.blueman-applet.enable = true;
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Set the minimum required home-manager version
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
