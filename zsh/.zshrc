# ===================== TMUX AUTO-ATTACH =====================
# If SSHing in and not already in tmux, attach or create a session
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ] && command -v tmux >/dev/null; then
	tmux new-session -A -s main
fi

# Go stuff
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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
[[ "$OS" == "Linux" ]] && command -v dircolors >/dev/null && eval "$(dircolors -b)"

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

autoload -Uz compinit
compinit

# ========================= TOOLS ==========================
export PATH="$HOME/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

if [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    fpath+=/opt/homebrew/share/zsh-completions
    # fzf keybindings (Ctrl+R for history, Ctrl+T for file, Alt+C for cd)
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
else
    # fzf keybindings (Ctrl+R for history, Ctrl+T for file, Alt+C for cd)
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && \
        source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && \
        source /usr/share/doc/fzf/examples/completion.zsh
fi

# fzf preview with bat (use batcat on Ubuntu, bat elsewhere)
if command -v batcat >/dev/null; then
	export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range=:500 {}' --preview-window=right:60%"
elif command -v bat >/dev/null; then
	export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range=:500 {}' --preview-window=right:60%"
fi
export FZF_ALT_C_OPTS="--preview 'ls -la {}' --preview-window=right:40%"

# Starship prompt
eval "$(starship init zsh)"

# zoxide (smarter cd — use "z" to jump to frequent dirs)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# bat: on Ubuntu the binary is "batcat" due to a name conflict
command -v batcat >/dev/null && alias bat='batcat'

# ========================= PLUGINS =========================
# Fish-like autosuggestions + syntax highlighting (must be sourced LAST)
if [[ "$OS" == "Darwin" ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
