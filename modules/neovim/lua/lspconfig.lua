-- Set up lspconfig.

--  nvim-cmp supports more types of completion candidates than default lsp
--  override the capabilities sent to the server such that it can provide
--  these candidates during a completion request
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

-- Config lsp
-- lua
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
-- json
lspconfig.jsonls.setup {
  -- Enable language servers with the additional completion capabilities
  capabilities = capabilities,
  cmd = {
     "/home/qyin/.nix-profile/bin/vscode-json-languageserver", "--stdio"
  },
}
-- clangd
lspconfig['clangd'].setup {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
  -- Enable language servers with the additional completion capabilities
  capabilities = capabilities,
}
-- rust
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      }
    }
  }
}
-- CMake
lspconfig.cmake.setup{
    -- Enable language servers with the additional completion capabilities
    capabilities = capabilities
}
-- emmet
lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

-- Other languages
local servers = {'pyright', 'html'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities, -- offered by nvim-cmp
    }
end

