{ config, pkgs, ... }:

let
  #  code generation and refactorings for C/C++.
  c-mantic = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    name = "C-mantic";
    publisher = "cmantic";
    version = "0.9.0";
    sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
  };
in 
{

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      shd101wyy.markdown-preview-enhanced
      vscodevim.vim

      # C++
      # C/C++ completion, navigation, and insights (better than MS official C/C++ extension)
      llvm-vs-code-extensions.vscode-clangd
      twxs.cmake # lanuage support (syntax highlight, autocompletion...)
      ms-vscode.cmake-tools
      c-mantic

      # Python
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
    ];
    userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
      "[vim]"."autoSwitchInputMethod.enable" = true;
      "[vim]"."autoSwitchInputMethod.defaultIM" = 1;
      "[vim]"."autoSwitchInputMethod.obtainIMCmd" = "~/.nix-profile/fcitx5-remote";
      "[vim]"."autoSwitchInputMethod.switchIMCmd" = "~/.nix-profile/fcitx5-remote -t {im}";
    };
  };

  # Deps
  home.packages = with pkgs; [
    gcc
    gdb
    cmake
    clang-tools # clangd
  ];

}
