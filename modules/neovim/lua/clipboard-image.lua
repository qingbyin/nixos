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
    -- Normal mode mappings
    local leader_mappings = {
      p = { "<cmd>PasteImg<cr>", "Paste image" },
    }
    wk.register(leader_mappings, { prefix = "<leader>" })
  end,
})
