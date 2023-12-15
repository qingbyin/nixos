{ config, pkgs, ... }:

with import <nixpkgs> {};
let
virt-column = callPackage ./overlays/virt-column.nix { };
obsidian-nvim = callPackage ./overlays/obsidian-nvim.nix { };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./basic.vim;
    plugins = with pkgs.vimPlugins; [
      which-key-nvim
      {
        plugin = obsidian-nvim;
        type = "lua";
        config = builtins.readFile ./lua/obsidian.lua;
      }
      {
        plugin = nvim-colorizer-lua; # color preview
        type = "lua";
        config = "require'colorizer'.setup()";

      }
      # Code completion
      cmp-nvim-lsp # completion source for neovim builtin LSP client
      {
        plugin = nvim-lspconfig; # Quickstart configurations for the Nvim LSP client
        type = "lua";
        config = builtins.readFile ./lua/lspconfig.lua;
        
      }
      null-ls-nvim # Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
      cmp-buffer # completion source for buffer words
      cmp-path # completion source for paths
      cmp-cmdline # command line suggestions
      cmp_luasnip # Luasnip completion source for nvim-cmp
      lspkind-nvim # vscode-like completion icons
      {
        plugin = luasnip; # Snippet engine
        type = "lua";
        config = ''
            local luasnip = require("luasnip")
            luasnip.setup({
                history = true,
                delete_check_events = {"TextChanged", "InsertLeave"},
            })
            --  Use <C-j/k> to jump to next/previous placeholder
            vim.keymap.set({"i", "s"}, "<C-j>", function() luasnip.jump( 1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-k>", function() luasnip.jump(-1) end, {silent = true})
            -- Load local snippets in .config/nvim/snippets
            require("luasnip.loaders.from_snipmate").lazy_load()
        '';
      }
      {
        plugin = pkgs.unstable.vimPlugins.nvim-cmp;
        type = "lua";
        config = builtins.readFile ./lua/cmp.lua;
      }
      {
        plugin = lsp_signature-nvim;
        type = "lua";
        config = builtins.readFile ./lua/lsp_signature.lua;
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
      promise-async # nvim-ufo deps
      {
        plugin = nvim-ufo; #  folded lines like other modern
        type = "lua";
        config = ''
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            -- use treesitter as ufo main provider
            require('ufo').setup({
                    provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                    end
            })
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
          p.c p.cpp p.cmake
          p.rust
          p.org
          p.norg
          p.markdown p.markdown_inline]));
        type = "lua";
        config = ''
        require('nvim-treesitter.configs').setup{
            highlight = {enable = true},
            indent = {enable = true},
        }
        vim.api.nvim_set_hl(0, "@text.strong.markdown_inline", { link = "Identifier" })
        '';
      }
      {
        plugin = vim-orgmode;
      }
     {
       plugin = neorg;
       type = "lua";
       config = ''
           require('neorg').setup { load = {
                   ["core.defaults"] = {},
                   ["core.completion"] = {
                   config = { engine = "nvim-cmp"},
                   },
                   ["core.concealer"] = {}
               }
           }
       '';
     }
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
          colorscheme material
        '';
      }
      {
        plugin = tokyonight-nvim;
        # config = ''
        #   colorscheme tokyonight-moon
        # '';
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
                \ 'colorscheme': 'material',
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
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
            require("indent_blankline").setup {
                show_current_context = true,
                -- show_current_context_start = true,
            }
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./lua/gitsigns-config.lua;
      }
      {
        plugin = git-messenger-vim;
        config = ''
            " set the cursor goes into a popup window when running git-messenger
            let g:git_messenger_always_into_popup=v:true
            let g:git_messenger_no_default_mappings=v:true " Disable default mapping
            let g:git_messenger_include_diff='current'

            " Show git commit at current position
            nmap <space>gh <Plug>(git-messenger)


            function! s:setup_git_messenger_popup() abort
            " Go back/forward history in git messenger popup window
            nmap <buffer><C-k> o
            nmap <buffer><C-j> O
            " Close popup window
            nmap <buffer><Esc> q
            endfunction
            autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
        '';
      }
      {
        plugin = fcitx-vim;
        config = "let g:fcitx5_remote = '~/.nix-profile/bin/fcitx5-remote'";
      }
      {
        plugin = julia-vim;
        config = ''
        let g:latex_to_unicode_file_types = ".*"
        '';
      }
      {
        plugin = markdown-preview-nvim;
        config = ''
        let g:mkdp_browser = '/home/qyin/.nix-profile/bin/brave'
        let g:mkdp_theme = 'dark'
        '';
      }
      {
        plugin = virt-column;
        type = "lua";
        config = ''
            require("virt-column").setup { virtcolumn = "80,120" }
            vim.cmd[[highlight! link VirtColumn Comment]]
        '';
      }
      {
        plugin = copilot-lua;
        type = "lua";
        config = ''
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        '';
      }
      {
        plugin = copilot-cmp;
        type = "lua";
        config = ''
          require("copilot_cmp").setup()
        '';
      }
    ];
  };
  
#  programs.neovim.coc = {
#    enable = true;
#    pluginConfig = builtins.readFile ./coc.vim;
#  };

  xdg.configFile."nvim/snippets" = {
    source = ./snippets;
    recursive = true;
  };

  home.packages = with pkgs; [
    obsidian
    cmake-language-server
    nodejs_21 # requried by copilot
  ];
}
