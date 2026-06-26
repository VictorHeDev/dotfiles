# Claude User Instructions

## Environment
- **OS**: macOS (Apple Silicon) and Ubuntu Linux
- **Shell**: zsh with Starship prompt
- **Editor**: neovim (`nvim`)
- **Terminal**: Ghostty
- **Multiplexer**: tmux with TPM plugins
- **Dotfiles**: managed with GNU Stow at `~/dotfiles`

## Code Style
- Prefer concise, minimal solutions — no over-engineering
- No unnecessary comments; only add them when the why is non-obvious
- No docstrings or multi-line comment blocks
- Don't add error handling for scenarios that can't happen
- Default to no emojis in code or output unless asked

## Responses
- Keep responses short and direct
- No trailing summaries of what was just done
- No unsolicited refactors or feature additions beyond what was asked

## Tools & Packages
- Package manager: Homebrew on macOS, apt on Linux
- Python version management: pyenv
- Git UI: lazygit
- Docker UI: docker compose (`dc` alias)
- Always prefer ripgrep (`rg`) over grep, `fd` over find, `bat` over cat when available

## Repository Context
- Work projects live under `~/work/` (separate git identity configured via `.gitconfig-work`)
- Homelab server: `homelab` (192.168.1.194, user `wood`)
