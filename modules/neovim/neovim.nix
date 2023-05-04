{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile."nvim/init.vim".source = ./init.vim;
  xdg.configFile."nvim/modules" = {
    source = ./modules;
    recursive = true;
  };
  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
  xdg.configFile."nvim/UltiSnips" = {
    source = ./modules;
    recursive = true;
  };
}