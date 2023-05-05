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
      pkief.material-icon-theme
      zhuangtongfa.material-theme # one dark pro
      
      # vim
      asvetliakov.vscode-neovim
      xadillax.viml

      # C++
      # C/C++ completion, navigation, and insights (better than MS official C/C++ extension)
      llvm-vs-code-extensions.vscode-clangd
      twxs.cmake # lanuage support (syntax highlight, autocompletion...)
      ms-vscode.cmake-tools
      #c-mantic

      # Python
      ms-python.python
      ms-python.vscode-pylance
      # ms-toolsai.jupyter
    ];
    userSettings = {
      "files.autoSave" = "off";
      "editor.fontFamily" = "FiraCode Nerd Font Mono, WenQuanYi Micro Hei";
      "editor.lineNumbers" = "relative";
      "editor.renderWhitespace" = "boundary";
      "editor.acceptSuggestionOnEnter" = "off";
      "workbench.activityBar.visible" = false;
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = "One Dark Pro";
      "workbench.iconTheme" = "material-icon-theme";

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
      { # Fix navigation jump in the explorer
        "key" = "ctrl+l";
        "command" = "workbench.action.navigateRight";
      }
    ];
  };

  xdg.configFile."vscode.vim".source = ./vscode.vim;
}
