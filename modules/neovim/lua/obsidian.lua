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

    -- -- Optional, customize how names/IDs for new notes are created.
    -- note_id_func = function(title)
    --     -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    --     -- In this case a note with the title 'My new note' will given an ID that looks
    --     -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    --     local suffix = ""
    --     if title ~= nil then
    --         -- If title is given, transform it into valid file name.
    --         suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    --     else
    --         -- If title is nil, just add 4 random uppercase letters to the suffix.
    --         for _ = 1, 4 do
    --             suffix = suffix .. string.char(math.random(65, 90))
    --         end
    --     end
    --     return tostring(os.time()) .. "-" .. suffix
    -- end,
    -- Optional, set to true if you don't want Obsidian to manage frontmatter.
    disable_frontmatter = true,

    -- TODO: supported in new version
    mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        -- ["gf"] = require("obsidian.mapping").gf_passthrough(),
    },

})

local wk = require("which-key")
wk.register({
    o = {
        name = "obsidian",
        f = { "<cmd>ObsidianFollowLink<cr>", "Follow link" },
        n = { "<cmd>ObsidianLinkNew<cr>", "Create link" },
    },
}, { prefix = "<leader>" })
