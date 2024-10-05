{ pkgs, config, ... }:

with import <nixpkgs> {};
let
  virt-column = callPackage ./overlays/virt-column.nix { };
  # obsidian-nvim = callPackage ./overlays/obsidian-nvim.nix { };
  # copilot-cmp-latest = callPackage ./overlays/copilot-cmp-latest.nix { };
  # obsidian-bridge = callPackage ./overlays/obsidian-bridge.nix {};
  fromGithub = import ./overlays/fromGitHub.nix;
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./basic.vim;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = which-key-nvim;
        type = "lua";
        # config plugins only installed by nix
        config = builtins.readFile ./lua/vim-jukit.lua;
      }
      {
        plugin = nvim-colorizer-lua; # color preview
        type = "lua";
        config = "require'colorizer'.setup()";
      }
      # Config corresponding lsp tools for different languages
      {
        plugin = nvim-lspconfig; # Quickstart configurations for the Nvim LSP client
        type = "lua";
        config = builtins.readFile ./lua/lspconfig.lua;
      }
      # Universal interface for non-lsp-standard formatting/linting tools
      # see the demo in https://www.youtube.com/watch?v=SxuwQJ0JHMU
      # not need by now, because all the language I used have lsp tools
      # {
      #   plugin = none-ls-nvim;
      #   type = "lua";
      #   config = builtins.readFile ./lua/none-ls.lua;
      # }
      # Code completion
      cmp-nvim-lsp # completion source for neovim builtin LSP client
      cmp-buffer # completion source for buffer words
      cmp-path # completion source for paths
      cmp-cmdline # command line suggestions
      cmp_luasnip # Luasnip completion source for nvim-cmp
      lspkind-nvim # vscode-like completion icons (config in cmp.lua)
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
        plugin = nvim-cmp;
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
          p.python
          p.lua
          p.vim p.vimdoc
          p.rust
          p.org
          p.norg
          p.html
          p.yaml
          p.latex
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
        plugin = nvim-ts-context-commentstring;
        type = "lua";
        config = "require('ts_context_commentstring').setup{}";
      }
      {
        plugin = vim-orgmode;
      }
     # {
     #   plugin = neorg;
     #   type = "lua";
     #   config = ''
     #       require('neorg').setup { load = {
     #               ["core.defaults"] = {},
     #               ["core.completion"] = {
     #               config = { engine = "nvim-cmp"},
     #               },
     #               ["core.concealer"] = {}
     #           }
     #       }
     #   '';
     # }
      # easy terminal open/close, lazygit
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
        # dislike its purple modeline
        plugin = material-nvim;
        type = "lua";
        config = builtins.readFile ./lua/material.lua;
      }
      {
        # dislike its pink keywords
        plugin = tokyonight-nvim;
        # config = ''
        #   colorscheme tokyonight-moon
        # '';
      }
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = builtins.readFile ./lua/catppuccin.lua;
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./lua/lualine.lua;
      }
      lualine-lsp-progress # show lsp server start progress
      lsp-status-nvim # show lsp status in statusline
      # Indent guide
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
            require("ibl").setup {
              indent = { char = "▏" },
              exclude = { filetypes = {"help", "toggleterm", "dashboard", "alpha" } },
              scope = { show_end = false}
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
        " Show markdown code block symbol as ">" symbol
        " autocmd BufEnter *.md syntax match Entity "```" conceal cchar=→
        " let g:markdown_folding = 1 " Enable markdown folding
        let g:markdown_recommended_style = 0 " Do not modify shiftwidth
        '';
      }
      {
        plugin = fromGithub {
          user = "MeanderingProgrammer";
          repo = "render-markdown.nvim";
        };
        type = "lua";
        config = builtins.readFile ./lua/render-markdown.lua;
      }
      {
        plugin = obsidian-nvim;
        type = "lua";
        config = builtins.readFile ./lua/obsidian.lua;
      }
      # {
      #   plugin = obsidian-bridge;
      #   type = "lua";
      #   config = ''require('obsidian-bridge').setup()'';
      # }
      {
        plugin = virt-column;
        type = "lua";
        config = ''
            require("virt-column").setup { virtcolumn = "80,120" }
            vim.cmd[[highlight! link VirtColumn Comment]]
        '';
      }
      # {
      #   plugin = copilot-lua;
      #   type = "lua";
      #   config = ''
      #     require("copilot").setup({
      #       suggestion = { enabled = true },
      #       panel = { enabled = true },
      #       filetypes = {markdown = true}
      #     })
      #   '';
      # }
      # {
      #   # plugin = copilot-cmp;
      #   plugin = copilot-cmp-latest;
      #   type = "lua";
      #   config = ''
      #     require("copilot_cmp").setup()
      #   '';
      # }
      {
        plugin = neogen;
        type = "lua";
        config = builtins.readFile ./lua/neogen.lua;
      }
      {
        plugin = clipboard-image-nvim;
        type = "lua";
        config = builtins.readFile ./lua/clipboard-image.lua;
      }
      # vscode-like tab (i.e. buffer list in vim) UI
      {
        plugin = bufferline-nvim; # require nvim-web-devicons
        type = "lua";
        config = ''
          require'bufferline'.setup{}
          -- nvim map
          vim.keymap.set('n', '<Tab>', '<cmd>:BufferLineCycleNext<cr>')
          vim.keymap.set('n', '<S-Tab>', '<cmd>:BufferLineCyclePrev<cr>')
        '';
      }
      {
        plugin = nvim-ts-autotag;
        type = "lua";
        config = ''
          require('nvim-ts-autotag').setup{}
        '';
      }
    ];
  };
  
#  programs.neovim.coc = {
#    enable = true;
#    pluginConfig = builtins.readFile ./coc.vim;
#  };

  home.file.".config/nvim/snippets" = {
    source = config.lib.file.mkOutOfStoreSymlink ./snippets;
  };

  xdg.configFile."nvim/plugins.sh" = {
    source = ./externalPlugins/plugins.sh;
    executable =true;
  };

  home.packages = with pkgs; [
    obsidian
    cmake-language-server
    # nodejs_21 # requried by copilot
    pyright # python lsp
    clang-tools
    lua-language-server
    nodePackages.vscode-json-languageserver
    vscode-langservers-extracted # html/css/json/eslint
    nil # nix lsp server
  ];
}
