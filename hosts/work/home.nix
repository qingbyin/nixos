#
#  Home-manager configuration for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./work
#   │       └─ ./home.nix *
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ home.nix
#

{ pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/hyprland/home.nix  # Window Manager
    ];

  home = {                                # Specific packages for desktop
    packages = with pkgs; [
      # Applications
      onlyoffice-bin    # Office packages
      rclone            # Gdrive mount  ($ rclone config | rclone mount --daemon gdrive: <mount> | fusermount -u <mount>)
      wdisplays         # Display Configurator
    ];
  };

  services = {                            # Applets
    blueman-applet.enable = true;         # Bluetooth
    cbatticon = {
      enable = true;
      criticalLevelPercent = 10;
      commandCriticalLevel = ''notify-send "battery critical!"'';
      lowLevelPercent = 30;
      iconType = "standard";
    };
  };
}
