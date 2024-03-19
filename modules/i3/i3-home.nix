# i3wm

{ config, pkgs, ... }:

{

  xsession = {
    enable = true;
    # 将创建的脚本名从.xsession改为.xsessionrc
    # 因为ubuntu下用xsessionrc启动图形桌面
    scriptPath = ".xsessionrc";
  };
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = null;
    extraConfig = builtins.readFile ./i3.conf;
  };

  home.packages = with pkgs; [
      jq # requried lib for workspaces.sh
      i3status-rust # remove
      xautolock # Tool for auto lock (run i3lock) after a given time
      rofi
      lxappearance # Modify icon and themes
      feh # wallpaper setting
      i3-swallow # run app with hiding terminal window (send to the scratchpad)
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
      font: "文泉驿等宽微米黑 12";
  }
  @theme "android_notification.rasi"
  '';

  # i3lock with background images
  home.file.".local/bin/i3lock-img".text =
  ''
    #!/bin/bash

    SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | cut -d' ' -f7)"
    BGCOLOR="#000000"
    images=($(ls ~/.config/wallpapers/*.png))
    convert "''${images[ $RANDOM % ''${#images[@]} ]}" -gravity Center -background \
     $BGCOLOR -extent "$SCREEN_RESOLUTION" RGB:- \
     | i3lock --raw "$SCREEN_RESOLUTION":rgb -c $BGCOLOR -i /dev/stdin
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
