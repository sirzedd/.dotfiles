# DotFiles

This rep contains my personal dotfiles that I have been using between my computers.  

The goal has been to keep my personal configs separate from work by referencing my personal files from the work ones.  This allows me to add work specific in the machine and I won't worry about uploading anything.

## Mac

// remove the key accents when holding them
defaults write -g ApplePressAndHoldEnabled -bool false

// Allow repeating
defaults write -g ApplePressAndHoldEnabled 0'

defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

## bin/.local/bin

Contain my scripts for getting things done

## terminal

I tried to split up all the sources I use in terminal to keep them organized.  I might need to revisit this organization later.

## vim

Contains some of personal nvim configs


## Remapping Caps Lock to F18

Without Karabiner I had to remap keys like this.  

https://hidutil-generator.netlify.app/

https://rakhesh.com/mac/using-hidutil-to-map-macos-keyboard-keys/

Use hidutil or build a Launch Agent


## Installations

These installations will need to happen before these can work

### TMUX

#### Tmux plugins

https://github.com/tmux-plugins/tpm

### ripgrep

`brew install ripgrep`

### exa replacement for ls 

`brew install exa`

### Bat the cat replacement

`brew install bat`

### FD find replacement

`brew install fd`

### FZF

`brew install fzf`

Additional command to install useful key bindings and fuzzy completion:
Not sure I did this.

`$(brew --prefix)/opt/fzf/install`


## .dotfiles to follow for insperation 🤩
[ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles/tree/master/zsh)

## Optimization of zsh
[htr3n](https://htr3n.github.io/2018/07/faster-zsh/)

