local Plug = vim.fn['plug#']

vipngpastem.call('plug#begin', '~/.config/nvim/plugged')

Plug('scrooloose/nerdtree', {on = 'NERDTreeToggle'})

vim.call('plug#end')
