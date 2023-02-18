# hyprland home-manager config

{ config, pkgs, nix-doom-emacs, ... }:

{
  imports = [ hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # Enable a patched wlroots that can render HiDPI XWayland windows
      hidpi = true;
    };
    # Extra configuration to add to ~/.config/hypr/hyprland.conf
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  # Dependencies
  home.packages = with pkgs; [
    swaylock
    hyprpaper # wallpaper
    wl-clipboard
    wlr-randr
    grim # screenshot for wayland
    slurp # screenshot for wayland
  ];

  programs.waybar = {
    enable = true;
  };
  programs.mako.enable = true; # notification daemon for Wayland
  programs.waybar.enable = true;

  xsession.initExtra =
  '' 
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec = "exec Hyprland";
    fi
  '';

  home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
  };

}
