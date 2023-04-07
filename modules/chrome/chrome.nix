{ config, pkgs, user, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave; 
    extensions = [
      # SwitchyOmega
      { id = "padekgcemlokbadohgkifijomclgjgif";
        crxPath = "/home/qyin/.config/chrome/extensions/switchy_omega.crx";
        version = "2.5.21";
      }
        # New Tab, New Window
      { id = "dndlcbaomdoggooaficldplkcmkfpgff"; }
      # Tampemonkey
      { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; }
        # Vimium
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
      # 猫抓
      { id = "jfedfbgedapdagkghmgibemcoggfppbb"; }
      # Org Capture
      { id = "kkkjlfejijcjgjllecmnejhogpbcigdc"; }
      # Copy as Markdown
      { id = "fkeaekngjflipcockcnpobkpbbfbhmdn"; }
      # Sci-Hub X Now!
      { id = "gmmnidkpkgiohfdoenhpghbilmeeagjj"; }
    ];
  };
  xdg.configFile."chrome/extensions" = {
    source = ./extensions;
    recursive = true;
  };
}