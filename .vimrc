" Use Vim settings instead of shitty Vi ones. 
set nocompatible

" Autoreload on save.
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" ########## General Settings ##########

set number              " Line numbers
set history=1000            " :cmdline history
set autoread                " Reload externally modified files
set hidden              " Background text buffering
set noswapfile

set laststatus=2 " Enabled status line
set statusline+=%F " Show current file relative to working dir
set clipboard=unnamed " Use system clipboard

syntax on               " Syntax highlighting, wee!

" ########## Vundle Stuff  ##########

filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

" General plugins.
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Bundle 'davidhalter/jedi-vim.git'

" Javascript plugins.
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'

call vundle#end()

" ########## Formatting  ##########

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set backspace=indent,eol,start
imap jj <ESC>

filetype plugin on
filetype indent on

" ########## Style ##########

set guifont=Anonymous\ Pro:h18
colorscheme obsidian

" Show lines at the 80 and 120 character marks.
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")

" Turn trailing whitespace into smiley piles of poo.
set list
set listchars=""
set listchars+=tab:\ \ 
set listchars+=trail:💩

" ########## Plugin: Ctrl-p  ##########

" Don't index bullshit like node_modules.
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist'

" ########## Bracket matching junk  ##########
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function CloseBracket()
  if match(getline(line('.') + 1), '\s*}') < 0
    return "\<CR>}"
  else
    return "\<Esc>j0f}a"
  endif
endf

function QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<Esc>i"
  endif
endf

set pastetoggle=<F2> " Toggles the vim ability to paste

"pewpew"
