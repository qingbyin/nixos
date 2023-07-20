{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./basic.vim;
    plugins = with pkgs.vimPlugins; [
      which-key-nvim
      {
        plugin = pkgs.vimExtraPlugins.obsidian-nvim;
        type = "lua";
        config = builtins.readFile ./lua/obsidian.lua;
      }
      {
        plugin = nvim-colorizer-lua; # color preview
        type = "lua";
        config = "require'colorizer'.setup()";

      }
      nvim-lspconfig # Quickstart configurations for the Nvim LSP client
      null-ls-nvim # Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
      # Code completion
      cmp-nvim-lsp # completion source for neovim builtin LSP client
      cmp-buffer # completion source for buffer words
      cmp-path # completion source for paths
      cmp-cmdline # command line suggestions
      cmp_luasnip # Luasnip completion source for nvim-cmp
      luasnip # Snippet engine
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./lua/cmp.lua;
      }
      {
        plugin = renamer-nvim;
        type = "lua";
        config = ''
        require('renamer').setup {}
        vim.api.nvim_set_keymap('i', '<F2>', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<F2>', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
        '';
      }
      telescope-nvim
      telescope-fzf-native-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./lua/telescope.lua;
      }
      #
      vim-surround # Easy to add/delete/change pairs
      vim-repeat # Cooporated with surround.vim, so that ds, cs, yss can be repeated
      {
        plugin = vim-commentary; # Comment using <gcc>
        config = ''
            autocmd FileType nix setlocal commentstring=#\ %s
            autocmd FileType cpp setlocal commentstring=//\ %s
        '';
      }
      vim-smoothie # Smooth scroll
      vim-lastplace # Reopen files at the last edit position
      vim-toml
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = "require('nvim-autopairs').setup{}";
      }
      nvim-web-devicons # explorer file icons
      plenary-nvim
      {
        plugin =  (nvim-treesitter.withPlugins (p: [
          p.nix
          p.c p.cpp
          p.rust
          p.org
          p.markdown p.markdown_inline]));
        type = "lua";
        config = "require('nvim-treesitter.configs').setup{highlight={enable=true}}";
      }
      {
        plugin = vim-orgmode;
      }
#      {
#        plugin = neorg;
#        type = "lua";
#        config = ''
#            require('neorg').setup { load = {
#                    ["core.defaults"] = {},
#                    ["core.completion"] = {
#                    config = { engine = "nvim-cmp"},
#                    },
#                    ["core.concealer"] = {}
#                }
#            }
#        '';
#      }
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
          " Disable conceal at cursor
          let g:indentLine_concealcursor = ""
          let g:indentLine_conceallevel = 2
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
  
#  programs.neovim.coc = {
#    enable = true;
#    pluginConfig = builtins.readFile ./coc.vim;
#  };

  xdg.configFile."nvim/UltiSnips" = {
    source = ./UltiSnips;
    recursive = true;
  };

  home.packages = with pkgs; [
    obsidian
  ];
}
