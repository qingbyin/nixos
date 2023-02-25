# i3wm

{ config, pkgs, ... }:

{

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps; # use i3-gaps fork
    config = {
      bars = [ { position = "top"; statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml"; } ];
    };
  };

  # Dependencies

  home.packages = with pkgs; [
    i3status-rust
    i3lock-color
    xautolock
    rofi
    lxappearance # Modify icon and themes
    nitrogen
  ];

  services.unclutter.enable = true; # Auto hide cursor

  xdg.configFile."i3status-rust/config".source = ./i3status.toml;
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
