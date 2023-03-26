# i3wm

{ config, pkgs, ... }:

let
  blurlock = pkgs.writeShellApplication {
    name = "blurlock";
    runtimeInputs = [ pkgs.imagemagick ];
    text = builtins.readFile ./blurlock.sh;
  };
in
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
      blurlock
      xautolock
      rofi
      lxappearance # Modify icon and themes
      feh # wallpaper setting
  ];

  xdg.configFile."wallpapers" = {
    source = ../common/wallpapers;
    recursive = true;
  };
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
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 15;
        frame_width = 1;
        frame_color = "#788388";
        font = "Droid Sans 9";
      };

      urgency_low = {
        background = "#263238";
        foreground = "#556064";
        timeout = 10;
      };

      urgency_normal = {
        background = "#263238";
        foreground = "#F9FAF9";
        timeout = 10;
      };

      urgency_critical = {
        background = "#D62929";
        foreground = "#F9FAF9";
        timeout = 0;
      };
    };
  };

}
