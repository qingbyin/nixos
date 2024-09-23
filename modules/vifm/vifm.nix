{ config, pkgs, ... }:

{
  xdg.configFile."vifm/vifmrc".source = ./vifmrc;
  xdg.configFile."vifm/colors/palenight.vifm".source = ./palenight.vifm;

}
