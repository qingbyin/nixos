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

local wk = require("which-key")
wk.add({
  { "<leader>cs", "<cmd>lua require('luasnip.loaders').edit_snippet_files()<cr>", desc = "Edit snippets"},
})
