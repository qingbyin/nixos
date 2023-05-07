{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./basic.vim;
    plugins = with pkgs.vimPlugins; [
      # packer-nvim
      nvim-lspconfig # Quickstart configurations for the Nvim LSP client
      null-ls-nvim # Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
      vim-surround # Easy to add/delete/change pairs
      vim-repeat # Cooporated with surround.vim, so that ds, cs, yss can be repeated
      vim-commentary # Comment using <gcc>
      vim-smoothie # Smooth scroll
      vim-lastplace # Reopen files at the last edit position
      vim-toml
      # nvim-autopairs # use coc-pairs
      nvim-web-devicons # explorer file icons
      # lazygit
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = builtins.readFile ./lua/toggleterm.lua;
      }
      {
        plugin = alpha-nvim; # Startup greeter
        type = "lua";
        config = "require'alpha'.setup(require'alpha.themes.startify'.config)";
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./lua/nvim-tree-config.lua;
      }
      {
        plugin = vim-sneak;
        config = "let g:sneak#label = 1";
      }
      # Delete buffers (close files) without closing your windows 
      {
        plugin = vim-bbye;
        config = "nnoremap <space>q <cmd>Bdelete<cr>";
      }
      {
        plugin = which-key-nvim;
      }
      {
        plugin = material-vim;
        config = ''
          let g:material_theme_style = 'palenight'
          if (has('termguicolors'))
            set termguicolors
          endif
          colorscheme material
        '';
      }
      {
        plugin = lightline-vim;
        config = ''
          " Always enable modeline/tabline
          set laststatus=2
          set showtabline=2
          " Hide the mode info, e.g. -- NORM --
          set noshowmode
          " Show pressed keys on the right bottom
          set showcmd
          " Config the bottom modeline and the top tabline
          let g:lightline = {
                \ 'colorscheme': 'material_vim',
                \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ 'tabline': {
                \   'left': [ ['tabs'] ],
                \   'right': [ ['modified'] ]
                \ },
                \ 'component_type': {
                \   'tabs': 'filename'
                \ }
                \ }
          '';
      }
      # Indent guide
      {
        plugin = indentLine;
        config = ''
          " Show leading spaces
          let g:indentLine_leadingSpaceEnabled = 1
          let g:indentLine_leadingSpaceChar = '·'
          " Show idnent guide lines
          let g:indentLine_showFirstIndentLevel = 1
          let g:indentLine_char_list = ['|', '¦', '┆', '┊']
          " Show whitespace/tab/break explicitly (Use symbols similar to Office Word)
          " set list listchars=tab:→\ ,trail:·,precedes:←,extends:→,space:·
          set list listchars=tab:→\ ,trail:·
        '';
        
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./lua/gitsigns-config.lua;
      }
      {
        plugin = fcitx-vim;
        config = "let g:fcitx5_remote = '~/.nix-profile/bin/fcitx5-remote'";
      }
    ];
  };
  
  programs.neovim.coc = {
    enable = true;
    pluginConfig = builtins.readFile ./coc.vim;
  };

  xdg.configFile."nvim/UltiSnips" = {
    source = ./UltiSnips;
    recursive = true;
  };
}
