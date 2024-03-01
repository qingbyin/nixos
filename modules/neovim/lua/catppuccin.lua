require("catppuccin").setup({
  background = { -- :h background
    light = "latte",
    dark = "macchiato",
  },
  dim_inactive = {
    enabled = true, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    telescope = true,
    which_key = true,
    vim_sneak = true,
    indent_blankline = {
      enabled = true,
      scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      colored_indent_levels = false,
    },
  },
  compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
})

-- setup must be called before loading
vim.cmd[[colorscheme catppuccin]]
