
call plug#begin('~/.vim/plugged')

" template for basic import and license
Plug 'aperezdc/vim-template'

" auto completion
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }

" the engine of snippets
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. This is snippet contents
Plug 'honza/vim-snippets'

" indent line
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle' }

" tagbar, a overview of classes, functions, variables names
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" cool line in bottom
Plug 'vim-airline/vim-airline'

" move cursor easier
Plug 'easymotion/vim-easymotion'

" the vim file manager
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" improve search
Plug 'google/vim-searchindex'

" surround "'({[
Plug 'tpope/vim-surround'

" fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" comment code
Plug 'preservim/nerdcommenter'

" vim go support
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

"-------------------------------------------------------- plug setting

" YouCompleteMe, C-family Semantic Completion Engine
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0

" show function preview
let g:ycm_add_preview_to_completeopt = 1

" close function preview when complete
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" max number of complete menu
let g:ycm_max_num_candidates = 100

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-]>"
"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" indent setting
autocmd! User indentLine doautocmd indentLine Syntax | autocmd BufRead * IndentLinesReset
let g:indentLine_enabled = 0

" set tagbar sort by code's order
let g:tagbar_sort = 0
"let g:tagbar_autoclose = 1

"-------------------------------------------------------- autocmd

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

augroup filetypedetect

    " when I edit makefile, vim will not use space to replace tab
    autocmd FileType make setlocal noexpandtab

    " for open cl code
    autocmd BufRead,BufNewFile *.cl set filetype=c

    " set file indent
    autocmd BufRead *.html setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.vue setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.js setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.go setlocal ts=2 sw=2 sts=2
    "autocmd FileType python setlocal ts=2 sw=2 sts=2

    " disable indentLine while open json files
    autocmd Filetype json let g:indentLine_enabled = 0
    autocmd Filetype markdown let g:indentLine_enabled = 0

    " run program
    autocmd filetype c      nnoremap <F12> :w <bar> exec '!clear && gcc ' shellescape('%') ' && ./a.out' <CR>
    autocmd filetype cpp    nnoremap <F12> :w <bar> exec '!clear && g++ ' shellescape('%') ' && ./a.out' <CR>
    autocmd filetype python nnoremap <F12> :w <bar> exec '!clear && python ' shellescape('%') <CR>
    autocmd filetype java   nnoremap <F12> :w <bar> exec '!clear && javac ' shellescape('%') ' && java ' shellescape('%:r') <CR>
    autocmd filetype sh     nnoremap <F12> :w <bar> exec '!clear && bash ' shellescape('%') <CR>
    "autocmd filetype go     nnoremap <F12> :w <bar> exec '!clear && go run .' <CR>
    autocmd filetype go     nnoremap <F12> :w <bar> exec '!clear && go run ' shellescape('%') <CR>

    " remove all trailing whitespace
    autocmd BufWritePre * %s/\s\+$//e

augroup END

" auto open tagbar
"autocmd VimEnter * nested :call tagbar#autoopen(1)

" auto open NERDTree
"autocmd vimenter * NERDTree

" save the folding state
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END

"-------------------------------------------------------- Other setting

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
    syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" autoindent
set autoindent

" show line number
set number

" Set tabstop to tell vim how many columns a tab counts for.
" set each tab to 4 column
set tabstop=4

" Set shiftwidth to control how many columns text is indented
" indent size
set shiftwidth=4

" when insert new tab, it will replace to space
" When expandtab is set, hitting Tab in insert mode will produce the appropriate number of spaces.
set expandtab

" set enable 256 color
set t_Co=256

" always keep at least 20 lines visible
set scrolloff=20

" show current line
set cursorline

" show status in bottom right
set ruler

" Search ignore case
" Do case insensitive matching
set ignorecase

" Do smart case matching
set smartcase

" Incremental search
set incsearch

" set file encoding
set fileencoding=utf-8

" set highlight search
set hlsearch

" set show mode
set showmode

" Automatically save before commands like :next and :make
set autowrite

" Show (partial) command in status line.
set showcmd

" make backspace work
set backspace=indent,eol,start

" set line mark to show maximal characters can use
set colorcolumn=80

" copy max line
set viminfo='100,<1000,s100,h

" always open new split plane on right
set splitright

" set file format = unix
set fileformat=unix

" whitespace characters are made visible.
"set list

"------------------------------------------------------ highlight

" set line number color
highlight LineNr ctermfg=DarkGrey

" set  line mark color
highlight ColorColumn ctermbg=235

"highlight Visual term=reverse ctermbg=DarkGrey
highlight Visual ctermbg=DarkGrey

" cursor line
highlight CursorLine term=bold cterm=bold ctermbg=235

"-------------------------------------------------------- Key mapping
" disable arrow key to make myself to use hjkl
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" set visual search
vnoremap // y/<C-R>"<CR>

" to save read only file
cnoremap sudow w !sudo tee % > /dev/null

" remove all white space in the end of line
"nnoremap <F2> :%s/\s\+$//e<CR>

" turn off highlighting
nnoremap <F3> :noh<CR>

" indent line toggle
nnoremap <F7> :IndentLinesToggle<CR>

" tagbar toggle
nnoremap <F8> :TagbarToggle<CR>

" enable nerdtree
nnoremap <F9> :NERDTreeToggle<CR>

" fzf pen files in vertical split
nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>


"-------------------------------------------------------- Command
command Todo noautocmd vimgrep /TODO\|FIXME/gj % | cw


