return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")
      local ensure = { "go", "gomod", "gosum", "gowork", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "json", "yaml" }
      ts.install(ensure)

      -- start highlighting + indent for installed parsers on FileType
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          -- only start when a parser for this language is actually installed;
          -- language.add returns false (no error) when it can't be loaded, so
          -- non-code filetypes like oil/help won't hard-assert in start()
          if not lang then return end
          local ok, loaded = pcall(vim.treesitter.language.add, lang)
          if not ok or not loaded then return end
          vim.treesitter.start(args.buf, lang)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      local map = function(mode, lhs, capture, desc)
        vim.keymap.set(mode, lhs, function()
          select(capture, "textobjects")
        end, { desc = desc })
      end
      map({ "x", "o" }, "af", "@function.outer", "a function")
      map({ "x", "o" }, "if", "@function.inner", "inner function")
      map({ "x", "o" }, "ac", "@class.outer", "a class/struct")
      map({ "x", "o" }, "ic", "@class.inner", "inner class/struct")
      map({ "x", "o" }, "aa", "@parameter.outer", "a parameter")
      map({ "x", "o" }, "ia", "@parameter.inner", "inner parameter")

      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Prev function" })
    end,
  },
}
