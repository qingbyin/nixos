# system's configuration file to define what should be installed on the system for all users.
# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/i3/i3-nixos.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Nix Package Manager settings
  nix = {                                   
    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };

  # Network
  networking = {
    hostName = "${user}";
    networkmanager.enable = true; # Enable networking
    hosts = {
      "185.199.109.133" = [ "raw.githubusercontent.com" ];
      "185.199.111.133" = [ "raw.githubusercontent.com" ];
      "185.199.110.133" = [ "raw.githubusercontent.com" ];
      "185.199.108.133" = [ "raw.githubusercontent.com" ];
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    # "wheel": can use `sudo`
    # "video": can modify volume using keyboard 
    extraGroups = [ "networkmanager" "wheel" "video"];
    packages = with pkgs; [];
  };
  security.sudo.wheelNeedsPassword = false; # User does not need to give password when using sudo.

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [                
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-han-sans
    source-han-serif
    wqy_microhei
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS (e.g. Time New Roman)
    (nerdfonts.override { fonts = [ "FiraCode" ]; })# Nerdfont Icons override
    ];

    fontconfig.defaultFonts = {
      serif = [ "Source Han Serif" "Source Han Serif" ];
      sansSerif = [ "FiraCode" "WenQuanYi Micro Hei" ];
      monospace = [ "FiraCode" "WenQuanYi Micro Hei" ];
    };
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  # Other packages will be installed in home.nix
  environment.systemPackages = with pkgs; [
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

  # Sound (required by screensharing)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # If your settings aren't being saved for some applications (gtk3 applications, firefox),
  # like the size of file selection windows, or the size of the save dialog, you will need to enable dconf
  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:swapcaps"; # Remap cap lock to control
    # For nvidia support with wayland
    videoDrivers = ["intel" "nvidia" ];
  };

  # Setup a ssh server (Enable other machine to connect this host).
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      permitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      passwordAuthentication = false;
    };
    # sftp: interactive program to copy files over ssh
    allowSFTP = true;                     
  };

  # Required by udiskie
  services.udisks2.enable = true;
  # Required by bluman-applet
  services.blueman.enable = true;
  # Required by wayland
  security.polkit.enable = true;

  # Nvidia
  hardware.nvidia.modesetting.enable = true; # TO find the primary display
  hardware.nvidia.package =  config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.powerManagement.enable = false;
  hardware.opengl.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
