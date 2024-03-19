-- Set global variables in Lua
vim.g.jukit_output_new_os_window = 1
vim.g.jukit_mappings = 0 -- Disable default mappings
vim.g.jukit_highlight_markers = 0 -- Disable cell markers highlight


-- First, require the which-key plugin
local wk = require("which-key")

-- Define the Lua functions corresponding to the Vimscript commands
G_jukit_commands = {
  activate_conda = function()
    vim.cmd("JukitOut conda activate py3.8")
  end,
  send_section = function()
    vim.cmd("call jukit#send#section(0)")
  end,
  send_selection = function()
    vim.cmd("call jukit#send#selection()")
  end,
  send_line = function()
    vim.cmd("call jukit#send#line()")
  end,
  send_until_current_section = function()
    vim.cmd("call jukit#send#until_current_section()")
  end,
  send_all = function()
    vim.cmd("call jukit#send#all()")
  end,
  -- Add other functions here corresponding to other mappings...
}

-- Autocommand to set up key mappings for python filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Normal mode mappings
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":lua G_jukit_commands.send_section()<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "v", "<CR>", ":<C-U>lua G_jukit_commands.send_selection()<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":lua G_jukit_commands.send_all()<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "i", "<F5>", "<Esc>:lua G_jukit_commands.send_all()<CR>", { noremap = true })
    local leader_mappings = {
      c = {
        r = {":lua G_jukit_commands.activate_conda()<CR>", "Run jukit"},
        --  Execute all cells until the current cell
        c = { "<cmd>call jukit#send#until_current_section()<cr>", "Run Cells" },
        a = { "<cmd>call jukit#cells#create_above(0)<cr>", "Create Code Cell Above" },
        b = { "<cmd>call jukit#cells#create_below(0)<cr>", "Create Code Cell Below" },
        k = { "<cmd>call jukit#cells#move_up()<cr>", "Move Cell Up" },
        j = { "<cmd>call jukit#cells#move_down()<cr>", "Move Cell Down" },
      }
    }

    wk.register(leader_mappings, { prefix = "<leader>" })
  end,
})




