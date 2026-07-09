local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- nvim 0.12.3 bug: bundled lua treesitter query references non-existent "operator" field
autocmd("FileType", {
  pattern = "lua",
  group = augroup("disable_lua_ts", { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.stop, args.buf)
  end,
})

-- auto-reload files changed outside of neovim
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = augroup("auto_reload", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- restore cursor position on file open
autocmd("BufReadPost", {
  group = augroup("restore_cursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
