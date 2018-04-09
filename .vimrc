scriptencoding utf-8

" set iMproved mode
set nocompatible

" ------------------------ Vundle ------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle.vim

" keep Plugin commands between vundle#begin and vundle#end
call vundle#begin()

" let Vundle manage Vundle
Plugin 'vundlevim/vundle.vim'

Plugin 'andrewradev/linediff.vim'
Plugin 'bogado/file-line'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'docker/docker'
Plugin 'ekalinin/dockerfile.vim'
Plugin 'embear/vim-localvimrc'
Plugin 'johngrib/vim-game-code-break'
Plugin 'juliaeditorsupport/julia-vim'
Plugin 'junegunn/goyo.vim'
Plugin 'majutsushi/tagbar'
Plugin 'nvie/vim-flake8'
" Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'powerman/vim-plugin-ansiesc'
Plugin 'rdnetto/ycm-generator'
Plugin 'reedes/vim-pencil'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'valloric/youcompleteme'
Plugin 'vim-scripts/align'
Plugin 'vim-scripts/languagetool'
Plugin 'vim-scripts/swig-syntax'

call vundle#end()
" --------------------------------------------------------

" Nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500

set fileencodings=utf8,cp1251,cp866,koi8-r

set term=xterm

set listchars=eol:$,tab:>-

" Tabs
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent

" Speed up macros
set lazyredraw

set cpoptions-=m

" Search
set incsearch  " incremental search
set nohlsearch " no highlighting

set matchpairs+=<:>

" Search for tags recursively
set tags+=tags;/

" Selective case insensitivity
set ignorecase
set infercase

" path for autocompletion
set path=.

" set persistent undo
" set undofile

" Show full tags when doing search completion
set showfulltag

" Make backspace delete lots of things
set backspace=indent,eol,start

" Show us the command we're typing
set showcmd

" Try to show at least three lines of context while scrolling
set scrolloff=3

" Set maximum number of tabs (vim -p)
set tabpagemax=100

" Use the cool tab complete menu
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.o,*~,Makefile.in,*.a,*.la,*.dvi,*.aux
set suffixes+=.aux,.log,.dvi

set ruler

" Enable syntax highlighting
syntax on

" GUI
if has("gui_running")
    set guifont=Terminus\ 14
    set guioptions=agim
endif

" Enable filetype settings
if has("eval")
    filetype on
    filetype plugin on
    filetype indent on
endif

" Set vim colors
colorscheme desert256
" Use Vim 256 colorscheme in screen
set t_Co=256

" Enable folds
set nofoldenable

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
if has("autocmd")
    autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif
endif

" Word completion
set dictionary=/usr/share/dict/cracklib-small

" Tab work
set showtabline=2
noremap tl :tabnext<CR>
noremap th :tabprev<CR>
noremap tn :tabnew<CR>
noremap td :q<CR>

" I never use q:, but periodically hit it by mistake
nmap q: :q

" Quick file selection through CtrlP
noremap ,t :CtrlP<CR>
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_clear_cache_on_exit = 0

" Make <space> in normal mode go down a page rather than left a character
noremap <space> <C-f>

" Define language of file
set encoding=utf-8
set termencoding=utf-8

" More conventient PgUp/PgDown, making cursor stay in the same line and not
" move up/down as standard. As default scroll on C-Y/D is by half-screen, the
" binding is done to double press
nmap <PageUp>   <C-U><C-U>
imap <PageUp>   <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" If a bracket not the first symbol in line
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

noremap <F6>  :ccl<CR> " Close make window
noremap <F7>  :cp<CR>  " Go to next error
noremap <F8>  :cn<CR>  " Go to prev error
noremap <F9>            :!git diff     > .git.diff<CR>:tabnew<CR>:view .git.diff<CR>gg
noremap <S-F9>          :!git diff "%" > .git.diff<CR>:tabnew<CR>:view .git.diff<CR>gg
noremap <F11>           :!ctags -R --c++-kinds=+p --fields=+iatlS --extra=+q .<CR><CR>

iab todo TODO
iab fixme FIXME

" See changes since last saving to a file
command DiffOrig vert rightb new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Calendar
let g:calendar_diary = '~/.calendar'
let g:calendar_mark = 'right'

" Move on the wrapped line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Center window on search matches
nnoremap N Nzzzv
nnoremap n nzzzv

" switch files
nmap ,s :FSHere<CR>

" Use global clipboard if possible
if has('xterm_clipboard')
    set clipboard=unnamedplus
endif

" Insert a blank line below/above/after/prior and stay in normal mode
nnoremap ,o :put =''<CR>
nnoremap ,O :put! =''<CR>
nnoremap ,i i<space><Esc>
nnoremap ,a a<space><Esc>

" Luc Hermitte's C/C++ plugins let b:usemarks=""

" Set grep program to always generate a file-name
set grepprg=grep\ -nH\ $*

set langmap=æéó÷õáðòûïìäøôýúêëùåçíãþîñ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,ÆÉÓ×ÕÁÐÒÛÏÌÄØÔÝÚÊËÙÅÇÍÃÞÎÑ;abcdefghijklmnopqrstuvwxyz

let g:languagetool_jar='$HOME/local/opt/languagetool/languagetool-commandline.jar'

set guicursor=a:block-Cursor-blinkon0

" Project specific configuration
let g:localvimrc_name    = ".local_vimrc"
let g:localvimrc_ask     = 0
let g:localvimrc_sandbox = 0

" Highlight extra white space
let g:highlight_white = 1
highlight ExtraWhitespace ctermbg=lightred guibg=red
fun! ChangeHighlightWhite()
    if g:highlight_white
        let g:highlight_white = 0
        highlight ExtraWhitespace ctermbg=black    guibg=black
    else
        let g:highlight_white = 1
        highlight ExtraWhitespace ctermbg=lightred guibg=red
    endif
endfun
nnoremap ,w :call ChangeHighlightWhite()<CR>
if has("autocmd")
    au BufEnter * match ExtraWhitespace /\s\+$/
endif

" ------------------------ Scripts configuration ------------------------
" Align
vnoremap ,= :Align=<CR>

" flake8
let g:flake8_cmd="flake8-3"

" Goyo
" let g:goyo_width = 100

" NerdCommenter
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
map <F3>    <plug>NERDCommenterComment
map <F4>    <plug>NERDCommenterUncomment

" Syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs  = 1

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_whitelist = { 'python' : 1, 'cpp' : 1, 'cpp11': 1, 'c' : 1}
nnoremap ,jd :YcmCompleter GoTo<CR>

" ------------------------ Functions ------------------------
" Scroll inactive window
nmap <silent> <M-Down> :call ScrollOtherWindow("down")<CR>
nmap <silent> <M-Up>   :call ScrollOtherWindow("up")<CR>
fun! ScrollOtherWindow(dir)
	if a:dir == "down"
		let move = "\<C-E>"
	elseif a:dir == "up"
		let move = "\<C-Y>"
	endif
	exec "normal \<C-W>p" . move . "\<C-W>p"
endfun

" Use bc to calculate the value of selected expression
vnoremap ;bc "ey:call CalcBC()<CR>
function! CalcBC()
	let has_equal = 0

	" remove newlines and trailing spaces
	let @e = substitute (@e, "\n", "", "g")
	let @e = substitute (@e, '\s*$', "", "g")

	" if we end with an equal, strip, and remember for output
	if @e =~ "=$"
		let @e = substitute (@e, '=$', "", "")
		let has_equal = 1
	endif

	" sub common func names for bc equivalent
	let @e = substitute (@e, '\csin\s*(', 's (', "")
	let @e = substitute (@e, '\ccos\s*(', 'c (', "")
	let @e = substitute (@e, '\catan\s*(', 'a (', "")
	let @e = substitute (@e, "\cln\s*(", 'l (', "")

	" escape chars for shell
	let @e = escape (@e, '*()')

	" run bc, strip newline
	let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")

	" append answer or echo
	if has_equal == 1
		normal `>
		exec "normal a" . answer
	else
		echo "answer = " . answer
	endif
endfunction
