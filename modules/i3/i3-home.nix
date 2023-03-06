# i3wm

{ config, pkgs, ... }:

{
  home.file.".i3/config".source = ./i3.conf;
  xdg.configFile."i3status-rust/config.toml".source = ./i3status.toml;
  # rofi config
  xdg.configFile."rofi/android_notification.rasi".source = ./rofi-theme.rasi;
  xdg.configFile."rofi/config".text = ''
  configuration {
      kb-row-up: "Up,Control+k,Control+p";
      kb-row-down: "Down,Control+j,Control+n";
      kb-remove-to-eol: "";
      kb-accept-entry: "Return,KP_Enter";
  }
  @theme ".config/rofi/android_notification.rasi"
  '';
}
