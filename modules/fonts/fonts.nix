{ config, pkgs, ... }:

{
  # Make nix installed fonts available to the system by creating
  # `.config/fontconfig/config.d/10-hm-fonts.conf` file.
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
    noto-fonts-color-emoji
  ];

  # Set alias for san-serif, serif and monospace
  # i.e. set the default font for each category
  xdg.configFile."fontconfig/fonts.conf".text =
  ''
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
    <alias>
      <family>sans-serif</family>
      <prefer>
        <family>Source Han Sans</family>
        <family>FiraCode Nerd Font</family>
      </prefer>
    </alias>
    <alias>
      <family>serif</family>
      <prefer>
        <family>Source Han Serif</family>
        <family>Times New Roman</family>
      </prefer>
    </alias>
    <alias>
      <family>monospace</family>
      <prefer>
        <family>FiraCode Nerd Font Mono</family>
        <family>Noto Sans Mono CJK SC</family>
        <family>Noto Sans Mono CJK TC</family>
      </prefer>
    </alias>
  </fontconfig>
  '';

  # Create my own font combination
  # ref:https://github.com/alacritty/alacritty/issues/957
  xdg.configFile."fontconfig/conf.d/99-alias-fonts.conf".text = ''
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
  <fontconfig>
    <alias>
      <family>FiraCode SourceHanSerif</family>
      <prefer>
          <family>FiraCode Nerd Font</family>
          <family>Source Han Serif</family>
          <family>Noto Color Emoji</family>
          <family>Unifont</family>
      </prefer>
    </alias>
  </fontconfig>
  '';
}
