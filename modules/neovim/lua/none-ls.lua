local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua, -- lua
        null_ls.builtins.diagnostics.eslint, -- javascript
        null_ls.builtins.completion.spell, -- spell check
    },
})
