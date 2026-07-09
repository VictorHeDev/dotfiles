# Neovim Learning Plan: Beginner → Intermediate

---

## Stage 1 — Survive (Week 1)

The basics you must know before anything else.

### Modes
| Key | Mode |
|-----|------|
| `i` | Insert mode (type text) |
| `<Esc>` | Back to normal mode |
| `v` | Visual mode (select text) |
| `:` | Command mode |

### Essential Movement
| Key | Action |
|-----|--------|
| `h/j/k/l` | Left / down / up / right (stop using arrow keys) |
| `w` / `b` | Jump forward / backward by word |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Top / bottom of file |
| `{` / `}` | Jump up / down by paragraph/block |

### Essential Edits
| Key | Action |
|-----|--------|
| `x` | Delete character under cursor |
| `dd` | Delete line |
| `yy` | Yank (copy) line |
| `p` / `P` | Paste below / above |
| `u` | Undo |
| `<C-r>` | Redo |

**Goal:** navigate and edit a file without touching the mouse.

---

## Stage 2 — Operators + Motions (Week 2)

This is where Neovim's grammar clicks. Every operator works with every motion.

### Operators
| Key | Action |
|-----|--------|
| `d` | Delete |
| `y` | Yank |
| `c` | Change (delete + enter insert) |
| `>` / `<` | Indent / dedent |

### Motions
| Key | Action |
|-----|--------|
| `iw` | Inner word |
| `aw` | A word (includes surrounding space) |
| `i"` / `i(` / `i{` | Inside quotes / parens / braces |
| `a"` / `a(` / `a{` | Around (includes the delimiters) |

### Combinations (the grammar)
```
diw   delete inner word
ciw   change inner word
yi"   yank inside quotes
da{   delete around braces (including the braces)
>G    indent from current line to end of file
```

### mini.ai Extended Text Objects
```
vaf   select around function
daa   delete around argument
cia   change inside argument
```

### The `.` Repeat Trick
Make a change, press `.` to repeat it on the next occurrence.

Example: `ciw` + type new word + `<Esc>`, then `w.w.w.` to replace the next three occurrences.

---

## Stage 3 — Search & Replace (Week 3)

### In-file Search
| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `n` / `N` | Next / previous match |
| `*` | Search for word under cursor |
| `#` | Search backward for word under cursor |

### In-file Substitution
```vim
:s/old/new/          replace first match on current line
:s/old/new/g         replace all on current line
:%s/old/new/g        replace all in file
:%s/old/new/gc       replace all with confirmation (y/n each)
:%s/\<old\>/new/g    whole word match only
```

### For Code — Prefer LSP
- `<leader>rn` — rename a symbol everywhere via LSP (smarter than regex, handles scope)
- Use `:s` for text patterns, `<leader>rn` for code symbols

### Across Files
```vim
" 1. use <leader>fg to find all occurrences across the project
" 2. then replace across all quickfix results:
:cfdo %s/old/new/g | update
```

---

## Stage 4 — Macros (Week 4)

Macros record a sequence of keystrokes and replay them.

### Recording
```
qa        start recording into register 'a'
...       do your edits
q         stop recording
@a        replay macro
@@        replay last macro
5@a       replay 5 times
```

### Practical Example — add trailing comma to each line in a list
```
qa        start recording
$         go to end of line
a,        append a comma
<Esc>     back to normal
j         go to next line
q         stop recording
@a        replay on next line
10@a      replay 10 more times
```

### Tips
- Record macros that end by positioning you for the next use (e.g. move to next line)
- If a macro fails midway, `u` undoes everything it did
- Use `Q` in visual mode to run a macro on each selected line

### Viewing Registers
```vim
:reg a    show contents of register 'a'
:reg      show all registers
```

---

## Stage 5 — Visual Mode Power (Week 5)

### Visual Variants
| Key | Mode |
|-----|------|
| `v` | Characterwise |
| `V` | Linewise (select whole lines) |
| `<C-v>` | Blockwise (column select) |

### Block Editing (`<C-v>`) — Most Powerful
```
<C-v>     enter block mode
jjj       select 3 rows down
I         insert at start of each line
# type    your text
<Esc>     applies to all lines
```

Use this to add `//` comments to multiple lines, prefix lines with a value, etc.

### Visual + Substitute
```
V              select lines visually
:              auto-fills :'<,'>
s/old/new/g    replace only within selection
```

---

## Stage 6 — Marks & Jumps (Week 6)

### Marks
```
ma        set mark 'a' at current position
'a        jump to line of mark 'a'
`a        jump to exact position of mark 'a'
''        jump back to where you just were
```

### Jump List
| Key | Action |
|-----|--------|
| `<C-o>` | Jump back through history |
| `<C-i>` | Jump forward through history |

### Useful Built-in Jumps
| Key | Action |
|-----|--------|
| `%` | Jump to matching bracket / paren / brace |
| `g;` | Go to last edit position |
| `gi` | Go to last insert position (and enter insert) |

---

## Stage 7 — The Intermediate Toolkit (Ongoing)

### Command Line Tricks
```vim
:earlier 5m      revert file to how it was 5 minutes ago
:later 5m        go forward again
:g/pattern/d     delete all lines matching a pattern
:v/pattern/d     delete all lines NOT matching a pattern
```

### Registers
```
"ay    yank into register 'a'
"ap    paste from register 'a'
"+y    yank to system clipboard (use <leader>y)
"0p    paste the last yanked text (not deleted)
```

The `"0` register always holds your last **yank**, even if you've deleted things since. Use it when `p` pastes the wrong thing.

---

## Practice Strategy

Don't try to learn everything at once. Each week:

1. **Pick one thing** from the next stage
2. **Force yourself to use it** even when the old way feels faster
3. **It will feel slower for 2-3 days**, then become automatic

The order matters: operators + motions → search/replace → macros. Macros are just recorded operators and motions — if those aren't automatic, macros won't click.

**Best practice exercise:** open a Go file you've written and make edits using only what you've learned that week. No mouse, no arrow keys.
