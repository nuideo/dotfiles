"from: https://github.com/frank604/dotfiles/blob/master/.vimrc

set t_Co=16
call pathogen#infect()
syntax on
set background=dark " dark|light "
colorscheme solarized
filetype plugin on
filetype indent on

set tabstop=4
set shiftwidth=4
set expandtab


set ttyfast                             " don't lag…
set cursorline                          " track position
set nocompatible                        " leave the old ways behind…
set nowrap                              " don't wrap lines
set nobackup                            " disable backup files (filename~)
set splitbelow                          " place new files below the current
set showmatch                           " matching brackets & the like
set clipboard+=unnamed                  " yank and copy to X clipboard
set encoding=utf-8                      " UTF-8 encoding for all new files
set backspace=2                         " full backspacing capabilities (indent,eol,start)
set scrolloff=10                        " keep 10 lines of context
set number                              " show line numbers
set ww=b,s,h,l,<,>,[,]                  " whichwrap -- left/right keys can traverse up/down
set linebreak                           " attempt to wrap lines cleanly
set wildmenu                            " enhanced tab-completion shows all matching cmds in a popup menu
set spelllang=en_gb                     " real English spelling
set dictionary+=/usr/share/dict/words   " use standard dictionary
set wildmode=list:longest,full          " full completion options
let g:is_posix=1                        " POSIX shell scripts
let g:loaded_matchparen=1               " disable parenthesis hlight plugin
let g:is_bash=1                         " bash syntax the default for hlighting
let g:vimsyn_noerror=1                  " hack for correct syntax hlighting

set tabstop=4                           " tabs appear as n number of columns
set shiftwidth=4                        " n cols for auto-indenting
set expandtab                           " spaces instead of tabs
set autoindent                          " auto indents next new line

set hlsearch                            " highlight all search results
set incsearch                           " increment search
set ignorecase                          " case-insensitive search
set smartcase                           " uppercase causes case-sensitive search

set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\
set laststatus=2
set cmdheight=1

if has("autocmd")
    " always jump to the last cursor position
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif
    " specific settings for various filetypes
    autocmd BufRead,BufNewFile ~/.mutt/temp/mutt-* set ft=mail wrap linebreak nolist spell textwidth=0 wrapmargin=0
    autocmd BufRead *.md, *.txt, /tmp/vimprobable* set tw=80  nocindent nolist spell
    autocmd FileType tex set tw=80   " wrap at 80 chars for LaTeX files
endif

function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)
MapToggle <F4> number
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'
let g:Tex_CompileRule_dvi='latex -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode $*'

:nnoremap j jzz
:nnoremap k kzz

:noremap <silent> <Space> :silent noh<Bar>echo<CR>

cmap w!! w !sudo tee % > /dev/null

set colorcolumn=0
let s:color_column_old = 80

function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction

nnoremap <bar> :call <SID>ToggleColorColumn()<cr>

:command -nargs=1 Url :read !imgurl <args>
