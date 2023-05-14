require('obsidian').setup({
    templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M"
    },
})

local wk = require("which-key")
wk.register({
    o = {
        name = "obsidian",
        p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview hunk" },
        d = { "<cmd>Gitsigns toggle_deleted<cr>", "Show deleted hunk" },
        u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo hunk" },
    },
}, { prefix = "<leader>" })
