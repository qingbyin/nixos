vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    pattern = vim.fn.expand("~") .. "/notebook/**.md",
    callback = function()
              require('obsidian').setup({
                  templates = {
                      subdir = "templates",
                      date_format = "%Y-%m-%d",
                      time_format = "%H:%M"
                  },
                  daily_notes = {
                      folder = "calendar",
                  },
                  notes_subdir = "notes",
                  completion = {
                      nvim_cmp = true,  -- if using nvim-cmp, otherwise set to false
                  },
                  disable_frontmatter = true,
                  -- TODO: supported in new version
                  -- mappings = {
                  -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                  -- ["gf"] = require("obsidian.mapping").gf_passthrough(),
                  -- },
              })
          end,
})

local wk = require("which-key")
wk.register({
    o = {
        name = "obsidian",
        f = { "<cmd>ObsidianFollowLink<cr>", "Follow link" },
        n = { "<cmd>ObsidianLinkNew<cr>", "Create link" },
    },
}, { prefix = "<leader>" })
