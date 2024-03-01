local cfg = {
    hint_enable = true, -- virtual hint enable
    hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    floating_window = false,
}
require "lsp_signature".setup(cfg)
