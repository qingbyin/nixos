{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-gtk
    ];
  };

  environment.systemPackages = [
    pkgs.rime-data
  ];

  environment.sessionVariables = {
    GLFW_IM_MODULE = "ibus"; # IME support in kitty
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "\@im=fcitx";
    SDL_IM_MODULE = "fcitx";
  };

}
