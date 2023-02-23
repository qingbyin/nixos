# Sway windows manager configuration

{ config, pkgs, ... }:

let
  image = "watercolor-grunge.jpg";
in
{
  wayland.windowManager.sway = {
    enable = true;
    config.output = { "*" = {bg = ".config/backgrounds/${image} fill";};};
    # Extra configuration to add to ~/.config/sway/config
    extraConfig = builtins.readFile ./sway.conf;
    extraOptions = [ "--unsupported-gpu" ]; # For Nvidia GPU
  };

  # Dependencies
  home.packages = with pkgs; [
    swaylock
    swayidle
    swayimg # image viewer
    light # backlight management for wayland
    wl-clipboard # clipboard copy/paste for wayland (replace xclip)
    wdisplays         # Display Configurator GUI (replace arandr)
    sway-contrib.grimshot # screenshot for wayland
    # showmethekey # screencast tool to display your keys
    waypipe # X11 forwarding (replace "ssh -X")
    wofi # Launcher (replace rofi)
  ];
  programs.mako.enable = true; # notification daemon for Wayland 
  programs.waybar = {
    enable = true;
    # Auto start waybar with sway
    systemd ={
      enable = true;
      target = "sway-session.target";
    };
    style = builtins.readFile ./waybar.css;
  };
  xdg.configFile."waybar/config".source = ./waybar.json;

  # Wallpaper
  home.file.".config/backgrounds/${image}".source = ./${image};
  # wofi config
  xdg.configFile."wofi/config".text = ''
    key_up = Control_L-k
    key_down = Control_L-j
    '';
  # Enable wayland support for chrome and electron apps
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}

