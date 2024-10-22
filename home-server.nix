# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, ...}:

{

  home = {
    username = "qyin";
    homeDirectory = "/home/qyin";
  };

  # 配置 ~/.config/nix/nix.conf
  nix.package = pkgs.nix;
  nix.settings = {
    substituters = "https://mirrors.sustech.edu.cn/nix-channels/store https: //cache.nixos.org/";
  };
  nix.gc.automatic = true; # 自动定时运行清除不用的包

  # 配置~/.config/nixpkgs/config.nix
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Modify environment setings to make nix compatiable with distro like Ubuntu
  targets.genericLinux.enable = true;

  imports = [
    ./modules/fonts/fonts.nix
    # ./modules/emacs/emacs.nix
    ./modules/common/zsh.nix
    ./modules/alacritty/alacritty.nix
    ./modules/neovim/neovim.nix
  ];

  # Install packages with plugins and configs
  home.packages = with pkgs; [
    vim
    wget
    usbutils # lsusb
    pciutils # lspci
    xdg-utils
    gnupg
    xcape
    xclip

    # Terminal
    btop              # Resource Manager
    nitch             # Minimal fetch (faster than screenfetch)
    tldr              # Helper (simplified man pages)
    fd
    ripgrep
    ripgrep-all
    cloc # count code lines

    # Apps
    appimage-run      # Runs AppImages on NixOS

    rclone
    freerdp # remote desktop

    # lazy
    lazydocker
    lazygit

    # File Management
    unzrip # 新版 unzip解决中文乱码：unzip -O cp936
    unrar
    zip
    p7zip
  ];

  # Configure keymap in X11
  # services.xcape = {
  #   enable = true;
  #   mapExpression = { Caps_Lock = "Control_L";};

  programs.git = {
    enable = true;
    userName  = "Qing Yin";
    userEmail = "qingbyin@gmail.com";
  };

  programs.gpg.enable = true;

  # Set the minimum required home-manager version
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
