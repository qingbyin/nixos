{ config, pkgs, ... }:
{

  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      i3status-rust
      i3lock-color
      xautolock
      rofi
      lxappearance # Modify icon and themes
      nitrogen
   ];
  };
  # Without a display manager
  services.xserver.displayManager.startx.enable = true;
  # Disable xterm windows manager
  services.xserver.desktopManager.xterm.enable = false;

  services.unclutter.enable = true; # Auto hide cursor
}

