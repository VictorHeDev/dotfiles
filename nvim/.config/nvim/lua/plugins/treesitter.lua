local parsers = {
  "go", "gomod", "gosum", "gowork",
  "lua", "vim", "vimdoc", "query",
  "markdown", "markdown_inline",
  "bash", "json", "yaml",
}

-- lua excluded: nvim 0.12.3 bundled lua query bug, see config/autocmds.lua
local highlight_filetypes = {
  "go", "gomod", "gosum", "gowork",
  "vim", "vimdoc", "query",
  "markdown", "markdown_inline",
  "bash", "json", "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = highlight_filetypes,
        group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local map = vim.keymap.set

      map({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "Around function" })
      map({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "Inside function" })
      map({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end, { desc = "Around class" })
      map({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, { desc = "Inside class" })
      map({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end, { desc = "Around argument" })
      map({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end, { desc = "Inside argument" })

      map("n", "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
      map("n", "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Previous function start" })
    end,
  },
}
