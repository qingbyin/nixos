-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
require('telescope').setup {
    defaults = {
        path_display = {"truncate"},
        -- path_display = {
        --     shorten = {len = 1, exclude = {1, -1}}
        -- },
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-u>"] = false, -- Enable clear the telescope prompt on <C-u>
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        },
        vimgrep_arguments = {
            "rg",
            "--vimgrep",
            "--smart-case",
            "--no-ignore-vcs"
        },
        -- FIXME: not working
        -- pickers = {
        --     find_files = {
        --         find_command = {
        --             "fd",
        --             ".",
        --             "--type",
        --             "file",
        --             "--hidden",
        --             "--no-ignore-vcs",
        --             "--strip-cwd-prefix"
        --         },
        --         no_ignore = true,
        --         theme = "ivy",
        --     },
        --     live_grep = {
        --         theme = "ivy",
        --     },
        -- },
        file_ignore_patterns = {"^.git/", "^build/", "^devel/", "node_modules"},
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local wk = require("which-key")
wk.add({
    { "<leader>f", group = "file" },
    { "<leader>fO", "<cmd>Telescope lsp_workspace_symbols theme=ivy<cr>", desc = "List all Symbol" },
    { "<leader>fa", "<cmd>Telescope diagnostics theme=ivy<cr>", desc = "LSP Diagnostics" },
    { "<leader>fb", "<cmd>Telescope buffers theme=ivy<cr>", desc = "Find opening file" },
    { "<leader>ff", "<cmd>Telescope find_files theme=ivy<cr>", desc = "Find File" },
    { "<leader>fg", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Global grep" },
    { "<leader>fh", "<cmd>Telescope help_tags theme=ivy<cr>", desc = "Help menu" },
    { "<leader>fm", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
    { "<leader>fo", "<cmd>Telescope lsp_document_symbols theme=ivy<cr>", desc = "List buffer Symbol" },
    { "<leader>x", "<cmd>Telescope commands theme=ivy<cr>", desc = "cmd" },
  -- f = {
  --   name = "file", -- optional group name
  --   f = { "<cmd>Telescope find_files theme=ivy<cr>", "Find File" },
  --   g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Global grep" },
  --   b = { "<cmd>Telescope buffers theme=ivy<cr>", "Find opening file" },
  --   h = { "<cmd>Telescope help_tags theme=ivy<cr>", "Help menu" },
  --   m = { "<cmd>Telescope keymaps<cr>", "Find keymaps" },
  --   o = {"<cmd>Telescope lsp_document_symbols theme=ivy<cr>", "List buffer Symbol"},
  --   O = {"<cmd>Telescope lsp_workspace_symbols theme=ivy<cr>", "List all Symbol"},
  --   a = {"<cmd>Telescope diagnostics theme=ivy<cr>", "LSP Diagnostics"},
  -- },
})

vim.api.nvim_set_keymap('n', '<C-p>',
  '<cmd>Telescope find_files find_command=fd,--no-ignore-vcs theme=ivy<cr>', { noremap = true, silent = true })
vim.keymap.set("n", "/", "<cmd>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case theme=ivy<cr>")

wk.add({
    { "gd", "<cmd>Telescope lsp_implementations<cr>", desc = "To impletation" },
    { "gf", "<cmd>Telescope lsp_definitions<cr>", desc = "To definition" },
    { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Cursor hover" },
    { "gr", "<cmd>Telescope lsp_references theme=ivy<cr>", desc = "List references" },
    { "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "To type definition" },

})
