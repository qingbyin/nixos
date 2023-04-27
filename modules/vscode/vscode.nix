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
      asvetliakov.vscode-neovim

      # C++
      # C/C++ completion, navigation, and insights (better than MS official C/C++ extension)
      llvm-vs-code-extensions.vscode-clangd
      twxs.cmake # lanuage support (syntax highlight, autocompletion...)
      ms-vscode.cmake-tools
      #c-mantic

      # Python
      # ms-python.python
      # ms-python.vscode-pylance
      # ms-toolsai.jupyter
    ];
    userSettings = {
      "files.autoSave" = "off";
      "editor.fontFamily" = "FiraCode Nerd Font Mono, WenQuanYi Micro Hei";
      "editor.lineNumbers" = "relative";
      "editor.renderWhitespace" = "boundary";
      "editor.acceptSuggestionOnEnter" = "false";

      "[nix]"."editor.tabSize" = 2;

      "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim}/bin/nvim";
      "vscode-neovim.neovimInitVimPaths.linux" = "~/.config/vscode.vim";

      "clangd.onConfigChanged" = "restart";
    };
    keybindings = [
      {
        "key" = "ctrl+[";
        "command" = "vscode-neovim.escape";
        "when" = "editorTextFocus && neovim.init";
      }
      {
        "command" = "-vscode-neovim.send";
        "key" = "ctrl+a";
      }
    ];
  };

  # Deps
  home.packages = with pkgs; [
    neovim
    # gcc
    # gdb
    # cmake
    # clang-tools # clangd
  ];

  xdg.configFile."vscode.vim".source = ./vscode.vim;
}
