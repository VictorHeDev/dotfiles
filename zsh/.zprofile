# zprofile is sourced for login shells and is a good place to set ENV VARs

# Load pyenv automatically
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"

# macOS default paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
