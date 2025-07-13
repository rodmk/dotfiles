# dotfiles

Personal dotfiles, managed with [chezmoi](https://chezmoi.io/).

## Installation

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rodmk
```

Or clone and run the install script:

```bash
git clone https://github.com/rodmk/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

## Coder

To use with [Coder](https://coder.com/):

```bash
coder dotfiles --yes https://github.com/rodmk/dotfiles.git
```

## License

MIT
