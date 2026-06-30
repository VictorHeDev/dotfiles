# Neovim Config

Minimal hand-rolled config using lazy.nvim. Managed with GNU Stow.

## Setup

```bash
git clone https://github.com/VictorHeDev/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow nvim
nvim  # lazy.nvim bootstraps and installs all plugins on first launch
```

## Plugins

### Core
| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager, self-bootstrapping |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme |

### LSP & Completion
| Plugin | Purpose |
|--------|---------|
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Installs LSP servers, linters, formatters |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridges mason with Neovim's built-in LSP |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting (goimports + gofmt on save) |

### Navigation
| Plugin | Purpose |
|--------|---------|
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder for files, grep, buffers, symbols |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer (edit filesystem like a buffer) |

### Editor
| Plugin | Purpose |
|--------|---------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git hunk navigation, staging, blame |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints popup |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | Session save/restore per directory |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Renders markdown in-buffer |

### mini.nvim
All from [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim):

| Module | Purpose |
|--------|---------|
| mini.pairs | Auto-closes brackets, quotes |
| mini.surround | Add/delete/replace surrounding characters |
| mini.statusline | Statusline showing mode, git, diagnostics, position |
| mini.notify | Corner notification popups |
| mini.cursorword | Highlights all occurrences of word under cursor |

---

## Keymaps

Leader key: `Space`

### Finding (fzf-lua)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Open buffers |
| `<leader>fr` | Recent files |
| `<leader>fw` | Grep word under cursor |
| `<leader>fd` | Document diagnostics |
| `<leader>fs` | Document symbols |
| `<leader>fh` | Help tags |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>cf` | Format file |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>q` | Diagnostics to loclist |

### Git
| Key | Action |
|-----|--------|
| `<leader>lg` | Open lazygit in floating window |

### Git Hunks (gitsigns)
| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

### File Explorer (oil)
| Key | Action |
|-----|--------|
| `-` | Open oil in current file's directory |
| `_` | Open oil in project root |
| `<CR>` | Open file or directory |
| `-` | Go up a directory |
| `d` | Mark for delete |
| `r` | Rename |
| `<C-s>` | Save changes |
| `g?` | Show oil keymaps |

### Session (persistence)
| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session for current directory |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Stop saving current session |

### Surround (mini.surround)
| Key | Action |
|-----|--------|
| `sa` + motion + char | Add surround (`saiw"` wraps word in quotes) |
| `sd` + char | Delete surround (`sd"` removes quotes) |
| `sr` + old + new | Replace surround (`sr"'` swaps `"` for `'`) |

### Windows & Buffers
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate between splits |
| `<C-w>v` | Vertical split |
| `<C-w>s` | Horizontal split |
| `<C-w>q` | Close window |
| `<C-w>=` | Equalize window sizes |
| `:bd` | Close current buffer |

### Editing
| Key | Action |
|-----|--------|
| `<C-d>` / `<C-u>` | Scroll down / up (cursor centered) |
| `J` / `K` (visual) | Move selection down / up |
| `<leader>y` | Yank to system clipboard |
| `<leader>p` (visual) | Paste without clobbering register |
| `<leader>d` | Delete to void register |

---

## Notes

- **Go formatting**: `goimports` runs before `gofmt` on save. Requires `goimports` installed (`go install golang.org/x/tools/cmd/goimports@latest`).
- **LSP servers**: `gopls` and `lua_ls` are auto-installed by mason on first launch.
