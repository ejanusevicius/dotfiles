# Eddie's .files
Hello, this repository contains all of tooling configuration for software development.

### Tooling
* **Alacritty** - terminal application
* **Tmux** - terminal multiplexer
* **Neovim** - text editor
* **Lazygit** - UI for git

### File structure
`/alacritty` - confuration files for `alacritty`

`/nvim` - configuration files for `neovim`

`tmux.conf` - configuration files for `tmux`

### Symlinks
Below are all of the SYMLINKS to connect the dotfiles:

```zsh
ln -s ~/.dotfiles/alacritty ~/.config/alacritty
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
```

