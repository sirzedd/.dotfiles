" to pull from ~/.vimrc
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath=&runtimepath
" source ~/.vimrc

" Reference .dotfiles https://github.com/ThePrimeagen/.dotfiles

" Tab options
" Can find options with :h tabstop
set shiftwidth=4
set expandtab
set smartindent

set guicursor=
set relativenumber
set nu

" turn off search
set nohlsearch

" keep everything open, faster swapping between stuff 
set hidden
" turn off bells
set noerrorbells

" stop wrapping text
set nowrap

" Keeps history
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch

" as you get to the bottom you'll automatically scroll
set scrolloff=8

" Red line guideline
set colorcolumn=100

" Column for errors
set signcolumn=yes

" Set to auto read when a file is changed from the outside
set autoread

" plugins, vim-plug https://github.com/junegunn/vim-plug

call plug#begin('~/.dotfile/vim/plugged')

" Plug 'nvim-telescope/telescope.nvim'

" Neovim tree sitter
" provide some basic functionality such as highlighting
" https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" telescope requirements...
" To check health of telescope
" :checkhealth telescope 
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Color scheme gruvbox
Plug 'gruvbox-community/gruvbox'


" undotree https://github.com/mbbill/undotree
" undo toggle
Plug 'mbbill/undotree'


" Tabline, bottom bar
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugins to look into
"NEOVIM LSP
"Telescope
"Tree sitter
"gruvbox CE
"Undo tree
"Fugitive

" Initialize plugin system
call plug#end()


colorscheme gruvbox
"colorscheme desert
"colorscheme monokai
highlight Normal guibg=none


" ----REMAPS---

" mode lhs rhs
" mode n normal" "no recursive execution " map
let mapleader = " "
" nvim plugin mappers there are other ones https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/plugin/telescope.vim
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" reload nvim with leader sv
nnoremap <leader>sv :source $MYVIMRC<CR>

" Faster copy to clipboard and pasting from clipboard
set clipboard=unnamed
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p


