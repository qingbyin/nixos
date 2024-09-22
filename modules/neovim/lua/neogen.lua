require('neogen').setup {
  enabled = true,
  snippet_engine = "luasnip",
}

local wk = require("which-key")
wk.add({
  { "<leader>c", group = "code" },
  { "<leader>cd", "<cmd>Neogen<cr>", desc = "docstring" },
})
