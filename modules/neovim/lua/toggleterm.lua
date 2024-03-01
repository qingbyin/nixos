require'toggleterm'.setup{
  open_mapping = [[<c-\>]],
}

-- set lazygit
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})
function _lazygit_toggle()
  lazygit:toggle()
end

-- Terminal window mappings
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local wk = require("which-key")
wk.register({
  t = { "<cmd>lua require('toggleterm').toggle()<cr>", "Terminal" },
  g = {
    g = { "<cmd>lua _lazygit_toggle()<cr>", "lazygit" },
  }
  
}, { prefix = "<leader>" })
