return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.statusline").setup({ use_icons = true })
    require("mini.notify").setup()
    vim.notify = require("mini.notify").make_notify()
    require("mini.cursorword").setup()
    require("mini.ai").setup()
  end,
}
