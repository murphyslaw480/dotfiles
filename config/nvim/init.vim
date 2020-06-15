" Plugins {{{
"

set rtp+=/usr/share/myrddin/vim
set rtp+=/usr/share/vim/vimfiles

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'rafaeldelboni/vim-gdscript3'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'puremourning/vimspector'
Plug 'thalesmello/webcomplete.vim'

call plug#end()

" }}}

" General Settings {{{

filetype plugin indent on

" appearance and information
colorscheme solarized
set bg=dark
set rnu             " Relative numbering
set nu              " full line number on current line
set showmatch       " show matching brackets
set scrolloff=3     " number of screen lines to show around cursor

" tab handling
set expandtab       " tabs = spaces
set smarttab
set tabstop=4       " 4 space tabs
set shiftwidth=4
set cino=(1s        " only indent one shiftwidth continuing an open paren
set cc=+1

" wild menu
set wildmenu              " Command line completion
set wildmode=longest,list " Complete up to longest common string, then list
set wildignore+=*.swp,*.bak,*.pyc,Session.vim
set wildignorecase

" searching
set ignorecase
set smartcase

" Folding
set foldmethod=indent
set foldnestmax=12
set foldlevelstart=99

" Completion
set completeopt=menuone,noselect

" diff
set diffopt=vertical

" other behavior
set splitbelow
set nostartofline
set autoread
set inccommand=nosplit

" don't redraw when executing things like macros
set lazyredraw

" set mapleader here so it applies to all future keymaps
let mapleader = "," " use , as leader character

" load project-local vimrc if it exists (after ftplugin)
if filereadable(".vim.local") | so .vim.local | endif
au BufRead,BufNewFile .vim.local set filetype=vim

" Make autoread pick up changes after resuming from suspend
augroup improved_autoread
  autocmd!
  autocmd FocusGained * silent! checktime
  autocmd BufEnter * silent! checktime
augroup end
noremap <c-z> :suspend<cr>:silent! checktime<cr>

augroup templates
  autocmd BufNewFile *.gd exec '0r ' . stdpath('config') . '/skel/skel.gd'
augroup END

" }}}

" General Keymaps {{{

" tap jk to exit intert mode (should be uncommon in normal typing)
inoremap jk <esc>

" Y yanks to end of line instead of whole line -- more like D and C
nnoremap Y y$

" format entire file
nnoremap <leader>= mzgg=G`z<cr>

" jump to previous tab
let g:lasttab = 1
nmap gl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" clipboard paste
noremap <leader>v :read !xclip -out -sel clip<cr>

" error jumping (first, next, previous)
nnoremap ge :lfirst<cr>
nnoremap gn :lnext<cr>
nnoremap gp :lprevious<cr>
nnoremap gc :lclose<cr>

" command to save and exit while creating a session file
command! Bye :mksession! | :wqall

" substitution (line, global, confirm)
noremap sl :s/\<<c-r><c-w>\>//g<left><left>
noremap sg :%s/\<<c-r><c-w>\>//g<left><left>
noremap sc :%s/\<<c-r><c-w>\>//gc<left><left><left>

" find symbol in current directory
map <leader>f :vimgrep  ./**<left><left><left><left><left>
map <leader>F :vimgrep <c-r><c-w> src/**<cr>

" delete trailing whitespace
nmap <leader>dt :%s/\s\+$//g<cr>

" quickly open a tab to edit important files
command! EditFtp exe "tabnew" resolve("$HOME/.config/nvim/ftplugin/" . &ft . ".vim")
command! EditVimrc exe "tabnew" resolve("$HOME/.config/nvim/init.vim")
command! EditVimLocal exe "tabnew" resolve(".vim.local")
nmap <leader>ev :EditVimrc<CR>
nmap <leader>el :EditVimLocal<CR>
nmap <leader>ef :EditFtp<CR>

nnoremap <c-l> :set spell! spell?<cr>

" insert a uuid
inoremap <c-u> <c-r>=system("uuidgen \| tr -d '\n'")<cr>

" }}}

" fugitive {{{

noremap <leader>gs :Gstatus<cr>
noremap <leader>gd :Gdiff<cr>
noremap <leader>gD :Gdiff HEAD~<cr>
noremap <leader>gp :Gpush<cr>

set diffopt="filler,vertical"

" }}}

" solarized {{{

" enable 256 colors
set t_Co=16
set t_AB=[48;5;%dm
set t_AF=[38;5;%dm

" set colorscheme, dark bg
set bg=dark
colorscheme solarized

" }}}

" airline {{{

let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#whitespace#enabled = 1

" Get rid of encoding/format to make more space for file name
let g:airline_section_y = ''

" Short-form mode symbols
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" }}}

" fzf {{{

let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
    \ 'ctrl-t': 'tab-split' }

let g:fzf_history_dir='~/.local/share/fzf-history'

nnoremap <c-p> :Files<cr>
nnoremap <c-e> :GFiles<cr>
nnoremap <c-g> :Rg<space>
nnoremap <c-k> :Rg <c-r><c-w><cr>
nnoremap <c-h> :Help<cr>

" }}}

" tabular {{{
"
nnoremap <leader>a :Tabularize /

" }}}

" ale {{{
call ale#linter#Define('gdscript3', {
\   'name': 'gdscript3',
\   'lsp': 'socket',
\   'address': 'localhost:6008',
\   'project_root': '/home/rcore/gamedev/quest',
\})
" }}}

" deoplete {{{
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#webcomplete#script = "~/.config/nvim/plugged/webcomplete.vim/sh/qutebrowser/webcomplete"

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
" }}}

" vim:foldmethod=marker:foldlevel=0