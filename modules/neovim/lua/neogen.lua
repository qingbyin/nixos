require('neogen').setup {
  enabled = true,
  snippet_engine = "luasnip",
}

local wk = require("which-key")
wk.register({ c = { name = "code", d = {"<cmd>Neogen<cr>", "docstring"} } },
  {prefix = "<leader>"})
