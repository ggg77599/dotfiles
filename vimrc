"-------------------------------------------------------- Vundle

set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'aperezdc/vim-template'

"Plugin 'Valloric/YouCompleteMe'

" vim must enable python
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" indent line
Plugin 'Yggdroot/indentLine'

" tagbar
Plugin 'majutsushi/tagbar'

" cool line in bottom
Plugin 'vim-airline/vim-airline'

" move cursor easier
Plugin 'easymotion/vim-easymotion'

" the vim file manager
Plugin 'scrooloose/nerdtree'

" improve search
Plugin 'google/vim-searchindex'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"-------------------------------------------------------- Vundle setting

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
"let g:indentLine_char = '|'

" set tagbar sort by code's order
let g:tagbar_sort = 0
"let g:tagbar_autoclose = 1

"-------------------------------------------------------- Other setting

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

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

" when I edit makefile, vim will not use space to replace tab
autocmd FileType make setlocal noexpandtab

augroup filetypedetect
    au BufRead,BufNewFile *.cl set filetype=c
augroup END

" set enable 256 color
set t_Co=256

" set python file indent = 2
"autocmd FileType python setlocal ts=2 sw=2 sts=2

" set html filr indent = 2
autocmd BufRead *.html setlocal ts=2 sw=2 sts=2

" disable indentLine while open json files
autocmd Filetype json let g:indentLine_enabled = 0
autocmd BufRead *.md let g:indentLine_enabled = 0

" auto open tagbar
"autocmd VimEnter * nested :call tagbar#autoopen(1)

" auto open NERDTree
"autocmd vimenter * NERDTree

" always keep at least 7 lines visible
set scrolloff=20

" show current line
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=235

" show status in bottom right
set ruler

" Search ignore case
" Do case insensitive matching
set ignorecase

" Do smart case matching
set smartcase

" Incremental search
set incsearch

" set line number color
highlight LineNr ctermfg=DarkGrey

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

"set cmdheight=2

" make backspace work
set backspace=indent,eol,start

" set line mark to show maximal characters can use
set colorcolumn=80

" set  line mark color
highlight ColorColumn ctermbg=235

"highlight Visual term=reverse ctermbg=DarkGrey
highlight Visual ctermbg=DarkGrey

" save the folding state
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END


" copy max line
set viminfo='100,<1000,s100,h

" always open new split plane on right
set splitright

" set file format = unix
set fileformat=unix

" show line return as '$'
"set list

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

" turn off highlighting
nnoremap <F3> :noh<CR>

" remove all white space in the end of line
nnoremap <F4> :%s/\s\+$//e<CR>

" run the current python file
nnoremap <F5> :!clear & python ./%<CR>

" enable tagbar
nnoremap <F8> :TagbarToggle<CR>

nnoremap <F7> :IndentLinesToggle<CR>

" enable nerdtree
map <C-n> :NERDTreeToggle<CR>

"inoremap ( ()<Esc>i
"inoremap " ""<Esc>i
"inoremap ' ''<Esc>i
"inoremap [ []<Esc>i
"inoremap {<CR> {<CR>}<Esc>ko

"--------------------------------------------------

" To turn off autoindent when you paste code
"set paste

" set mouse mode
"set mouse=a

" replace all tab to space
":retab

