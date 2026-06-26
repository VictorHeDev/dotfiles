return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({ "telescope" })

    local map = vim.keymap.set
    map("n", "<leader>ff", fzf.files, { desc = "Find files" })
    map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
    map("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
    map("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
    map("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
    map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Document diagnostics" })
    map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document symbols" })
    map("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word under cursor" })
  end,
}
