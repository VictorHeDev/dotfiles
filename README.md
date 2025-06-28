# Victor's Dotfiles

This repository contains the many dotfiles which I like to be shared across my development machines. I primarily use MacOS and Linux (Fedora), and the dotfiles are managed using the GNU Stow project. To unpack the dotfiles and to symlink, simply

1. Clone this repo into the root directory
2. `cd` into this directory
3. Run:

  ```bash
  stow <filename>
  # stow bashrc
  ```

## Dry Run

If you would like to preview what stow will do before actually linking any dotfiles:

```bash
stow -nv bashrc  # dry run
```
