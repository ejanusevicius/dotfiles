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


### Useful Stuff

How to enable scroll in `tmux`?
* Run `setw -g mouse on` command in the `tmux` command prompt (opened with `Leader + :`)
* `Leader + [` to undo this i.e. scroll through command history.
