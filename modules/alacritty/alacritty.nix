{ config, pkgs, ... }:

{
  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
}
