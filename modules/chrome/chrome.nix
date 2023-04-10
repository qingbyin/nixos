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
      { id = "dndlcbaomdoggooaficldplkcmkfpgff";
        crxPath = "/home/qyin/.config/chrome/extensions/new_tab.crx";
        version = "3.4";
      }
      # Tampemonkey
      { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; 
        crxPath = "/home/qyin/.config/chrome/extensions/tampemonkey.crx";
        version = "4.18.1";
      }
      # Vimium
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb";
        crxPath = "/home/qyin/.config/chrome/extensions/vimium.crx";
        version = "1.67.4";
      }
      # 猫抓
      { id = "jfedfbgedapdagkghmgibemcoggfppbb";
        crxPath = "/home/qyin/.config/chrome/extensions/cat_capture.crx";
        version = "2.3.1";
      }
      # Org Capture
      { id = "kkkjlfejijcjgjllecmnejhogpbcigdc";
        crxPath = "/home/qyin/.config/chrome/extensions/org_capture.crx";
        version = "0.2.1";
      }
      # Copy as Markdown
      { id = "fkeaekngjflipcockcnpobkpbbfbhmdn";
        crxPath = "/home/qyin/.config/chrome/extensions/markdown_link.crx";
        version = "2.7.1";
      }
      # Sci-Hub X Now!
      { id = "gmmnidkpkgiohfdoenhpghbilmeeagjj";
        crxPath = "/home/qyin/.config/chrome/extensions/scihub.crx";
        version = "0.2.2";
      }
    ];
  };
  xdg.configFile."chrome/extensions" = {
    source = ./extensions;
    recursive = true;
  };
}
