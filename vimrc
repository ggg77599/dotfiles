
" import vim-plug plugin and settings
if !has("nvim")
  source ~/.vimrc.plug
endif


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

" the augroup name `filetypedetect` is conflict with `sheerun/vim-polyglot`
augroup filetypedetect_vimrc

    " when I edit makefile, vim will not use space to replace tab
    autocmd FileType make setlocal noexpandtab

    "" set syntax highlight file type
    " for open cl code
    autocmd BufRead,BufNewFile *.cl set filetype=c
    autocmd BufRead,BufNewFile .util.* set filetype=bash
    autocmd BufRead,BufNewFile gitconfig* set filetype=gitconfig
    autocmd BufRead,BufNewFile vimrc* set filetype=vim
    autocmd BufRead,BufNewFile ~/.kube/* set filetype=yaml

    " set file indent
    autocmd BufRead *.html setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.yml setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.yaml setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.vue setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.js setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.sh setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.go setlocal ts=2 sw=2 sts=2 noexpandtab
    autocmd BufRead *.proto setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.lua setlocal ts=2 sw=2 sts=2
    autocmd BufRead *.json setlocal ts=2 sw=2 sts=2
    "autocmd FileType python setlocal ts=2 sw=2 sts=2

    " run program
    "autocmd filetype c      nnoremap <F12> :w <bar> exec '!clear > /dev/null && gcc ' shellescape('%') ' && ./a.out && rm a.out' <CR>
    "autocmd filetype cpp    nnoremap <F12> :w <bar> exec '!clear > /dev/null && g++ ' shellescape('%') ' && ./a.out && rm a.out' <CR>
    "autocmd filetype rust   nnoremap <F12> :w <bar> exec '!clear > /dev/null && rustc ' shellescape('%') ' -o a.out && ./a.out && rm a.out' <CR>
    "autocmd filetype python nnoremap <F12> :w <bar> exec '!clear > /dev/null && python ' shellescape('%') <CR>
    "autocmd filetype java   nnoremap <F12> :w <bar> exec '!clear > /dev/null && javac ' shellescape('%') ' && java ' shellescape('%:r') <CR>
    "autocmd filetype sh     nnoremap <F12> :w <bar> exec '!clear > /dev/null && bash ' shellescape('%') <CR>
    "autocmd filetype go     nnoremap <F12> :w <bar> exec '!clear > /dev/null && go run ' shellescape('%') <CR>
    " using BufEnter,BufRead to let keymap reset every time we enter a buffer
    autocmd BufEnter,BufRead *
                \ if &filetype == 'c' |
                \   nnoremap <F12> :w <bar> exec '!clear > /dev/null && gcc ' shellescape('%') ' && ./a.out && rm a.out' <CR>|
                \ elseif &filetype == 'cpp'    |
                \   nnoremap <F12> :w <bar> exec '!clear > /dev/null && g++ ' shellescape('%') ' && ./a.out && rm a.out' <CR>|
                \ elseif &filetype == 'rust'   |
                \   nnoremap <F12> :w <bar> exec '!clear > /dev/null && rustc ' shellescape('%') ' -o a.out && ./a.out && rm a.out' <CR>|
                \ elseif &filetype == 'python' |
                \   nnoremap <F12> :w <bar> exec '!clear > /dev/null && python ' shellescape('%') <CR>|
                \ elseif &filetype == 'java'   |
                \   nnoremap <F12> :w <bar> exec '!clear > /dev/null && javac ' shellescape('%') ' && java ' shellescape('%:r') <CR>|
                \ elseif &filetype == 'sh'     |
                \   nnoremap <F12> :w <bar> exec '!clear > /dev/null && bash ' shellescape('%') <CR>|
                \ elseif &filetype == 'go'     |
                \   nnoremap <F12> :w <bar> exec '!clear > /dev/null && go run ' shellescape('%') <CR>|
                \ endif |

    " run project
    autocmd filetype go     nnoremap <F10> :w <bar> exec '!clear > /dev/null && go run .' <CR>

    " remove all trailing whitespace
    autocmd BufWritePre *\(.out\|.diff\)\@<! :call TrimWhitespace()

    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow

augroup END

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

" always keep at least 20 lines visible (top/down)
set scrolloff=20

" always keep at least 50 lines visible (left/right)
set sidescrolloff=50

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

" always open new split plane on right and down
set splitright
set splitbelow

" set file format = unix
set fileformat=unix

" whitespace characters are made visible.
"set list

" no wrap lines
set nowrap

" set max number of charactor of syntax in a line, default is 3000
set synmaxcol=8000

" enable show both line numbers
"call RltvNmbr#RltvNmbrCtrl(1)
"set relativenumber

" do not create the swap file
set noswapfile

" spell check
set spell

" set max text length of a line
set textwidth=80

" disable mouse mode
set mouse=""

"------------------------------------------------------ highlight

" set line number color
highlight LineNr ctermfg=DarkGrey

" set line mark color
highlight ColorColumn ctermbg=235

"highlight Visual term=reverse ctermbg=DarkGrey
highlight Visual ctermbg=DarkGrey

" cursor line
highlight CursorLine term=bold cterm=bold ctermbg=235

" search highlight
highlight Search cterm=NONE ctermfg=black ctermbg=Yellow

" spell check
highlight SpellBad cterm=underline ctermfg=NONE ctermbg=NONE

" folded
highlight Folded ctermbg=black
highlight Folded ctermfg=245

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
" https://stackoverflow.com/questions/6870902/how-can-i-search-a-word-after-selecting-it-in-visual-mode-in-vim
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" set vimgrep search
vnoremap <leader>/  y/<C-R>"<CR>:vimgrep /<C-R>"/g %<CR>
vnoremap <leader>a/ y/<C-R>"<CR>:vimgrep /<C-R>"/g **/*<CR>

" short for vimgrep
cnoremap vg vimgrep<space>

" to save read only file
cnoremap sudow w !sudo tee % > /dev/null

" vertical terminal
cnoremap vterm vertical term

" turn off highlighting
nnoremap <F3> :noh<CR>

" convert to big5
nnoremap <F4> :e ++enc=big5<CR>

" format json string
nnoremap <F5> :%!python -m json.tool<CR>

" copy selected content to OS clipboard
vnoremap <Leader>y "*y

" open directory view
nnoremap <Leader>o :b#<CR>

" open directory explore
nnoremap <Leader>e :Explore<CR>

" diff split windows, each windows do diffthis command
cnoremap diff :windo diffthis

"-------------------------------------------------------- Command
command Todo noautocmd vimgrep /TODO\|FIXME/gj % | cw

"-------------------------------------------------------- Function
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

let s:term_buf_nr = -1
function! s:ToggleTerminal() abort
    if s:term_buf_nr == -1
        execute "botright terminal"
        let s:term_buf_nr = bufnr("$")
    else
        try
            execute "bdelete! " . s:term_buf_nr
        catch
            let s:term_buf_nr = -1
            call <SID>ToggleTerminal()
            return
        endtry
        let s:term_buf_nr = -1
    endif
endfunction

" redir(ect)
" reference:
"   https://vi.stackexchange.com/questions/5729/how-can-i-perform-a-search-when-vim-displays-content-using-more-pager
"   https://stackoverflow.com/questions/49078827/can-listings-in-the-awful-more-be-displayed-instead-in-a-vim-window/49083560#49083560
function! Redir(cmd)
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if a:cmd =~ '^!'
        execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
    else
        redir => output
        execute a:cmd
        redir END
    endif
    vnew
    let w:scratch = 1
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(output, "\n"))
endfunction
command! -nargs=1 Redir silent call Redir(<f-args>)

nnoremap <silent> <Leader>t :call <SID>ToggleTerminal()<CR>
tnoremap <silent> <Leader>t <C-w>N:call <SID>ToggleTerminal()<CR>

" compare to Ctrl-G to show the current file name
nnoremap <silent> <Leader>g :!git url %<CR>

