-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
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
        file_ignore_patterns = {"^.git/", "^build/", "^devel/"},
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

local wk = require("which-key")
wk.register({
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files theme=ivy<cr>", "Find File" },
    g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Global grep" },
    b = { "<cmd>Telescope buffers theme=ivy<cr>", "Find buffer" },
    h = { "<cmd>Telescope help_tags theme=ivy<cr>", "Help menu" },
    m = { "<cmd>Telescope keymaps<cr>", "Find keymaps" },
    o = {"<cmd>Telescope lsp_document_symbols theme=ivy<cr>", "List buffer Symbol"},
    O = {"<cmd>Telescope lsp_workspace_symbols theme=ivy<cr>", "List all Symbol"},
    a = {"<cmd>Telescope diagnostics theme=ivy<cr>", "LSP Diagnostics"},
  },
  x = { "<cmd>Telescope commands theme=ivy<cr>", "cmd" },
}, { prefix = "<leader>" })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files find_command=fd,--no-ignore-vcs theme=ivy<cr>', { noremap = true, silent = true })
wk.register({
    d = {"<cmd>Telescope lsp_implementations<cr>", "To impletation"},
    f = {"<cmd>Telescope lsp_definitions<cr>", "To definition"},
    y = {"<cmd>Telescope lsp_type_definitions<cr>", "To type definition"},
    r = {"<cmd>Telescope lsp_references theme=ivy<cr>", "List references"},
    h = {"<cmd>lua vim.lsp.buf.hover()<cr>", "Cursor hover"},
}, { prefix = "g" })
