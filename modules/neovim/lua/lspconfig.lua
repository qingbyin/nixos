-- Set up lspconfig.

--  nvim-cmp supports more types of completion candidates than default lsp
--  override the capabilities sent to the server such that it can provide
--  these candidates during a completion request
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- Config lsp
-- lua
lspconfig.lua_ls.setup{}
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
-- Other languages
local servers = {'pyright'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities, -- offered by nvim-cmp
    }
end

