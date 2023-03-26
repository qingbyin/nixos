# i3wm

{ config, pkgs, ... }:

{

  xsession = {
    enable = true;
    scriptPath = ".xsessionrc";
  };
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = null;
    extraConfig = builtins.readFile ./i3.conf;
  };

  home.packages = with pkgs; [
      i3status-rust
      i3lock-color
      xautolock
      rofi
      lxappearance # Modify icon and themes
      feh # wallpaper setting
  ];

  home.file.".background-image".source = ../common/watercolor-grunge.jpg;
  xdg.configFile."i3status-rust/config.toml".source = ./i3status.toml;
  # rofi config
  xdg.configFile."rofi/android_notification.rasi".source = ./rofi-theme.rasi;
  xdg.configFile."rofi/config.rasi".text = ''
  configuration {
      kb-row-up: "Up,Control+k,Control+p";
      kb-row-down: "Down,Control+j,Control+n";
      kb-remove-to-eol: "";
      kb-accept-entry: "Return,KP_Enter";
  }
  @theme "android_notification.rasi"
  '';

  # Notification daemon
  services.dunst.enable = true;
}
