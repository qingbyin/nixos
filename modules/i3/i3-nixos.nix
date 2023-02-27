{ config, pkgs, ... }:
{

  windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      i3status-rust
      i3lock-color
      xautolock
      rofi
      lxappearance # Modify icon and themes
      nitrogen
   ];
  };

  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.unclutter.enable = true; # Auto hide cursor
}

