{ config, pkgs, ... }:

{
  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
}
