require 'clipboard-image'.setup {
  default = {
    img_dir = "img",
    img_name = function() return os.date('%Y%m%d%H%M%S') end,
    affix = "%s"
  },
  markdown = {
    affix = "%s"
  }
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    wk.add({"<leader>p","<cmd>PasteImg<cr>", desc = "Paste image"})
  end,
})
