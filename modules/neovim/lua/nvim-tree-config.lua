-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.keymap.set('n', '<leader>e', "<cmd>NvimTreeToggle<cr>", {silent = true})
-- Set keymapping in the explorer
local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    
    -- Enable default mappings
    api.config.mappings.default_on_attach(bufnr)
    -- User mappings
    vim.keymap.set('n', 'h',  api.node.navigate.parent_close,        opts('Close Directory'))
    vim.keymap.set('n', 'l',  api.node.open.edit,                    opts('Open'))
end

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = my_on_attach,
})
