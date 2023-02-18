# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, user, ... }: {

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModule
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./modules/emacs/emacs.nix
    ./moudles/sway/sway.nix
  ];

  # programs.neovim.enable = true;

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
    firefox-wayland
    google-chrome     # Browser
    onlyoffice-bin    # Office
    rclone

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
  programs.foot.enable = true;
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

   programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.firefox = {
  enable = true;
  package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    nixExtensions = [
      (fetchFirefoxAddon {
        name = "catcatch";
        url = "https://addons.mozilla.org/firefox/downloads/file/4066808/cat_catch-2.3.1.xpi";
      })
      (fetchFirefoxAddon {
        name = "switchyomega";
        url = "https://addons.mozilla.org/firefox/downloads/file/1056777/switchyomega-2.5.20.xpi";
      })
      (fetchFirefoxAddon {
        name = "sci-hub";
        url = "https://addons.mozilla.org/firefox/downloads/file/4067800/sci_hub_x_now-0.2.2.xpi";
      })
      (fetchFirefoxAddon {
        name = "org-capture";
        url = "https://addons.mozilla.org/firefox/downloads/file/1127481/org_capture-0.2.1.xpi";
      })
      (fetchFirefoxAddon {
        name = "org-link";
        url = "https://addons.mozilla.org/firefox/downloads/file/856347/org_link-1.0.xpi";
      })
      (fetchFirefoxAddon {
        name = "adblock-plus";
        url = "https://addons.mozilla.org/firefox/downloads/file/4067141/adblock_plus-3.16.1.xpi";
      })
      (fetchFirefoxAddon {
        name = "copy-selection-as-markdown";
        url = "https://addons.mozilla.org/firefox/downloads/file/3802383/copy_selection_as_markdown-0.21.0.xpi";
      })
      (fetchFirefoxAddon {
        name = "FreeDownloadManager";
        url = "https://addons.mozilla.org/firefox/downloads/file/3854169/free_download_manager_addon-3.0.57.xpi";
      })
      (fetchFirefoxAddon {
        name = "Tampermonkey";
        url = "https://addons.mozilla.org/firefox/downloads/file/4030629/tampermonkey-4.18.1.xpi";
      })
    ];

    extraPolicies = {
      # Gnome shell native connector
      enableGnomeExtensions = true;
      # Tridactyl native connector
      enableTridactylNative = true;
      ExtensionSettings = {};
    };
  };
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
