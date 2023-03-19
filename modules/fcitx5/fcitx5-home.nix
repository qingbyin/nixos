{ config, pkgs, ... }:

{
  xdg.configFile."fcitx5/profile".force = true;
  xdg.configFile."fcitx5/profile".source = ./profile;
  xdg.configFile."fcitx5/config".force = true;
  xdg.configFile."fcitx5/config".source = ./config;

  # Theme
  xdg.configFile."fcitx5/conf/classicui.conf".force = true;
  xdg.configFile."fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".local/share/fcitx5/themes/Nord/theme.conf".source = ./theme.conf;

  # rime
  home.file.".local/share/fcitx5/rime/default.custom.yaml".source = ./default.custom.yaml;
  home.file.".local/share/fcitx5/rime/double_pinyin_flypy.custom.yaml".source = ./double_pinyin_flypy.custom.yaml;

}
