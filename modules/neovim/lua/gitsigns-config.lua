-- keymappings
-- hunk info 
vim.keymap.set('n', '<leader>gp', "<cmd>Gitsigns preview_hunk<cr>", {silent = true})
vim.keymap.set('n', '<leader>gd', "<cmd>Gitsigns toggle_deleted<cr>", {silent = true})
vim.keymap.set('n', '<leader>gu', "<cmd>Gitsigns undo_stage_hunk<cr>", {silent = true})
-- Stage hunk
vim.keymap.set('n', '<leader>gs', "<cmd>Gitsigns stage_hunk<cr>")
-- Jump to previous/next hunk
vim.keymap.set('n', '<leader>gk', "<cmd>Gitsigns prev_hunk<cr>", {silent = true})
vim.keymap.set('n', '<leader>gj', "<cmd>Gitsigns next_hunk<cr>", {silent = true})

require('gitsigns').setup {
  -- signs = {
  --   add          = { text = '│' },
  --   change       = { text = '│' },
  --   delete       = { text = '_' },
  --   topdelete    = { text = '‾' },
  --   changedelete = { text = '~' },
  --   untracked    = { text = '┆' },
  -- },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
