# system's configuration file to define what should be installed on the system for all users.
# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Nix Package Manager settings
  nix = {                                   
    settings = {
      auto-optimise-store = true;           # Deduplicate and optimise syslinks in nix store
      experimental-features = [ "nix-command" "flakes" ];
    };
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

  pkgs.config.allowUnfree = true;        # Allow proprietary software.

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
  ];

  # backlight management for Wayland
  programs.light.enable = true;

  # Sound (required by screensharing)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:swapcaps"; # Remap cap lock to control
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
