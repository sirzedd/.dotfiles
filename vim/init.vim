" to pull from ~/.vimrc
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath=&runtimepath
"source ~/.vimrc

" reference .dotfiles https://github.com/theprimeagen/.dotfiles

" tab options

" when pressing tab, insert 2 spaces
set expandtab
set smartindent

" Ignore case when using /
set ignorecase

" show exiting tab with 2 spaces width
set tabstop=2

" when indenting with '>' use 2 spaces widths
set shiftwidth=2

"sets number of colums for a TAB
set softtabstop=2

set backspace=2 " more powerful backspacing

" 
set guicursor=
set relativenumber
set nu

" turn off search
set nohlsearch

" keep everything open, faster swapping between stuff 
set hidden

" turn off bells
set noerrorbells
set visualbell

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

" don't display welcome
set shortmess+=I

set history=700

" Set to auto read when a file is changed from the outside
set autoread


" plugins, vim-plug https://github.com/junegunn/vim-plug
" ---Plugins ---
"
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


" Seamless navigate vim and tmux splits
Plug 'christoomey/vim-tmux-navigator'

" TODO Commenting this out, needs java 11 to work properly 
" LSP Client and Autoinstaller
" Plug 'neovim/nvim-lspconfig'
" Plug 'williamboman/nvim-lsp-installer'
" Plug 'mfussenegger/nvim-jdtls'

" Plug 'VonHeikemen/lsp-zero.nvim'

" Auto Complete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

" ctrlp https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'


" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Autocompletion framework
Plug 'hrsh7th/nvim-cmp'
" cmp LSP completion
Plug 'hrsh7th/cmp-nvim-lsp'
" cmp Snippet completion
Plug 'hrsh7th/cmp-vsnip'
" cmp Path completion
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
" See hrsh7th other plugins for more great completion sources!

" Adds extra functionality over rust analyzer
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'


Plug 'tpope/vim-surround'


" Plugins to look into
"NEOVIM LSP
"Telescope
"Tree sitter
"gruvbox CE
"Undo tree
"Fugitive

" Initialize plugin system
call plug#end()

" commands

" command! Snip execute '. tmux-snippets.sh && rustysnippets'

" / commands

" ctrlp

  " Control working directory 
  let g:ctrlp_working_path_mode = 'ra'

  " Ignore .gitignore
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

  " let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

  " Ignore
  let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" end ctrlp
" START RUST LSP must be after plug#end
" Set completeopt to have a better completion experience 
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" END RUST LSP


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

nmap <CR> o<Esc>k

" Interactive replace all, one by one
nnoremap <leader><leader> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i
":nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" replace all with no mercy 🤯
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

nnoremap <Leader>r :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Exit insert mode by typing kj rather than esc
" http://www.guyrutenberg.com/2013/09/23/quickly-exiting-insert-mode-in-vim/
:inoremap kj <ESC>
" exit even if capital if in caps lock
:inoremap KJ <ESC>

