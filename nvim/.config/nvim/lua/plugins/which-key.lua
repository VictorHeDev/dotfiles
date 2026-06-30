return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>l", group = "lazygit" },
      { "<leader>q", group = "session" },
      { "<leader>t", group = "todos" },
      { "<leader>h", group = "git hunks" },
      { "<leader>r", group = "rename/refactor" },
      { "<leader>c", group = "code" },
      { "<leader>y", desc = "Yank to clipboard" },
      { "<leader>Y", desc = "Yank line to clipboard" },
      { "<leader>p", desc = "Paste without clobbering register", mode = "x" },
      { "<leader>d", desc = "Delete to void register", mode = { "n", "v" } },
      { "<leader>e", desc = "Show diagnostic float" },
      { "<leader>q", desc = "Diagnostics to loclist" },
    },
  },
}
