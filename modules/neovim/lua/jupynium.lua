require("jupynium").setup({
  python_host = { "conda", "run", "--no-capture-output", "-n", "py3.8", "python" },
  use_default_keybindings = false,
  textobjects = {
    use_default_keybindings = true,
  },
  jupyter_command = { "conda", "run", "--no-capture-output", "-n", "py3.8", "jupyter" },
  auto_download_ipynb = false,
})
local wk = require("which-key")
function SetJupynium()
    local fileTy = vim.api.nvim_buf_get_option(0, "filetype")
    local opts = { prefix = '<leader>', buffer = 0 }

    if fileTy == 'python' then
        wk.register({
            j = {
              name = "jupyer",
              R = { "<cmd>JupyniumStartAndAttachToServer<cr>", "Start" },
              S = { "<cmd>JupyniumStartSync<cr>", "Sync" },

              x = { "<cmd>JupyniumExecuteSelectedCells<cr>", "Execute" },
              h = { "<cmd>JupyniumKernelHover<cr>", "Hover" },
              f = { "<cmd>JupyniumShortsightedToggle<cr>", "Focus current cell" },
              s = {"<cmd>JupyniumSaveIpynb<cr>", "Save" },
            },
        }, opts)
    end
end
vim.cmd('autocmd FileType * lua SetJupynium()')
