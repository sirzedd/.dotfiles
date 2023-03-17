# Vim

## Description

I used to be a vim guru at demandware but many years of not using it has made me slow.  I'm slowing updating this buliding a new vim mojo.  I'm using NeoVim

## Usage

I source the `.dotfiles/vim/init.vim` file from my `~/.config/nvim/init.vim` like this

```
source ~/.dotfiles/vim/init.vim
```

My goal is to keep any work specific vim config (if there is any) in the `~/.config/nvim/init.vim` so I don't check anything into this repository. 

After starting vim I need to run `:PlugInstall` to install all those tasty plugins 🤤


## IDE

Install plugins

```
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-jdtls'
Plug 'nvim-lua/plenary.nvim'
```

install jdtls

```
brew install jdtls
```

or

```
sudo apt-get install eclipse-jdt-ls
```






