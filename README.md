# Victor's Dotfiles

Dotfiles for macOS (Apple Silicon) and Ubuntu server, managed with [GNU Stow](https://www.gnu.org/software/stow/). Goal: new development environment up and running in <30 minutes.

## First-time setup

### 1. Create an SSH key for GitHub

[Generate an SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and add it to your GitHub account before cloning.

### 2. Clone the repo

```bash
git clone git@github.com:VictorHeDev/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Run the setup script for your OS

**macOS:**
```bash
./setup_mac.sh

# With Kubernetes tools:
INSTALL_K8S=true ./setup_mac.sh
```

**Ubuntu server:**
```bash
./setup_linux.sh
```

The setup scripts will:
- Install packages
- Set up dotfiles via stow

## Machine automation

The [`automation/`](automation/README.md) directory contains the Ansible
foundation for bootstrapping workstations and the Ubuntu homelab. It uses the
stowed `homelab` SSH alias rather than committing connection details. See its
README for clean-controller setup, connection checks, and safe `--check`
previews before applying changes.

## Stow packages

| Package | Contents |
|---|---|
| `aliases` | Shell aliases |
| `claude` | Claude Code `CLAUDE.md` and custom skills |
| `git` | `.gitconfig`, `.gitignore` |
| `ghostty` | Terminal config |
| `hammerspoon` | Window management (macOS only) |
| `ssh` | SSH config |
| `zsh` | `.zshrc`, `.zshenv`, `.zprofile` |

To manually stow a package:
```bash
stow --target "$HOME" <package>
```

To preview what stow will do without making changes:
```bash
stow --dry-run --target "$HOME" <package>
```
