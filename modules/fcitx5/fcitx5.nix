{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
    ];
  };
  
  xdg.configFile."fcitx5/conf/pinyin.conf".source = ./pinyin.conf;
  xdg.configFile."fcitx5/conf/classicui.conf".source = ./classicui.conf;
}
