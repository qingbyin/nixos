-- Set up lspconfig.

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- Config lsp
-- clangd
lspconfig['clangd'].setup {
    cmd = { "clangd", "--log=verbose" },
    -- Enable language servers with the additional completion capabilities
    capabilities = capabilities
}
-- rust
lspconfig.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true;
            }
        }
    }
}
-- lspconfig.rust_analyzer.setup{}
-- Other languages
local servers = {'pyright'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities, -- offered by nvim-cmp
    }
end

