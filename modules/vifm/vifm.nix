{ config, pkgs, ... }:

{
  xdg.configFile."vifm/vifmrc".source = ./vifmrc;

}
