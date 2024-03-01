{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # Fonts
    source-han-sans
    source-han-serif
    wqy_microhei
    source-code-pro
    jetbrains-mono
    font-awesome
    corefonts # MS (e.g. Time New Roman)
    (nerdfonts.override { fonts = [ "FiraCode" ]; })# Nerdfont Icons override
  ];

  xdg.configFile."fontconfig/fonts.conf".text =
  ''
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
    <alias>
      <family>sans-serif</family>
      <prefer>
        <family>Noto Sans CJK SC</family>
        <family>Noto Sans CJK TC</family>
        <family>Noto Sans CJK HK</family>
        <family>Noto Sans CJK JP</family>
        <family>Noto Sans CJK KR</family>
        <family>Lohit Devanagari</family>
      </prefer>
    </alias>
    <alias>
      <family>serif</family>
      <prefer>
        <family>Noto Serif CJK SC</family>
        <family>Noto Serif CJK TC</family>
        <family>Noto Serif CJK JP</family>
        <family>Noto Serif CJK KR</family>
        <family>Lohit Devanagari</family>
      </prefer>
    </alias>
    <alias>
      <family>monospace</family>
      <prefer>
        <family>Noto Sans Mono CJK SC</family>
        <family>Noto Sans Mono CJK TC</family>
        <family>Noto Sans Mono CJK HK</family>
        <family>Noto Sans Mono CJK JP</family>
        <family>Noto Sans Mono CJK KR</family>
      </prefer>
    </alias>
  </fontconfig>
  '';
}
