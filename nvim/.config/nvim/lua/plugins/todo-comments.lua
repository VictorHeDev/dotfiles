return {
  "folke/todo-comments.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "Find todos" },
  },
}
