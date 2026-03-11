# Victor's Dotfiles

This repository contains the many dotfiles which I like to be shared across my development machines. I primarily use MacOS and Linux (Fedora), and the dotfiles are managed using the GNU Stow project. The goal of this setup is to have a new development environment up and running in <30 minutes.

## GitHub and Git

### Create new ssh key for GitHub

[Generate ssh key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) for GitHub repository access. 

### Clone repo in root directory

```git clone git@github.com:VictorHeDev/dotfiles.git```


## MacOS Setup

Uncomment the `mac_setup.sh` script which will:

- Install homebrew, programs, and applications specified in the `brew/` directory
```INSTALL_K8S=true ./setup_mac.sh```
- Set sane mac defaults
- Set up dotfiles

## GNU Stow

1. Clone this repo into the root directory
2. `cd` into this directory
3. Run:

  ```bash
  stow <directory_name>
  # stow bashrc
  ```

## Dry Run

If you would like to preview what stow will do before actually linking any dotfiles:

```bash
stow -nv bashrc  # dry run
```

## Set up Neovim

If you are cloning this dotfiles directory for the first time, run:

```bash 
git clone --recurse-submodules git@github.com:VictorHeDev/dotfiles.git
```

If you already have this dotfiles repository cloned onto your system, run:

```bash 
git submodule init
git submodule update
```

### MacOS

Run the Brewfile with the command `brew bundle`
