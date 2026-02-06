# ========================= OPTIONS =========================
setopt histignorealldups sharehistory
setopt hist_reduce_blanks       # remove extra blanks from history
setopt hist_verify              # show substituted history command before running
setopt auto_cd                  # type a directory name to cd into it
setopt correct                  # suggest corrections for mistyped commands

# Emacs keybindings
bindkey -e

# Fix backspace behavior
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char

# ========================= HISTORY =========================
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# ========================= ALIASES =========================
if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

# ======================== COMPLETION ========================
autoload -Uz compinit
compinit

command -v dircolors >/dev/null && eval "$(dircolors -b)"

# Case-insensitive completion (lowercase matches uppercase and vice versa)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# Arrow-key navigable completion menu
zstyle ':completion:*' menu select

# Colored completion results using LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Collapse double slashes
zstyle ':completion:*' squeeze-slashes true

# Group completions by type with headers
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' verbose true

# Use modern completion, disable old compctl style
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' completer _expand _complete _correct _approximate

# Kill command completions
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ========================= TOOLS ==========================
export PATH="$HOME/.local/bin:$PATH"

# fzf keybindings (Ctrl+R for history, Ctrl+T for file, Alt+C for cd)
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Starship prompt
eval "$(starship init zsh)"

# zoxide (smarter cd — use "z" to jump to frequent dirs)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# bat: on Ubuntu the binary is "batcat" due to a name conflict
command -v batcat >/dev/null && alias bat='batcat'

# ========================= PLUGINS =========================
# Fish-like autosuggestions (accept with right-arrow)
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be sourced LAST)
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
