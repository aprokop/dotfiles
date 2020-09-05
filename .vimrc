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

" utility
Plugin 'andrewradev/linediff.vim'           " compare two blocks of lines in a file
Plugin 'bogado/file-line'                   " allow opening files like 'file:80'
Plugin 'conradirwin/vim-bracketed-paste'    " use automatic 'set paste'
Plugin 'ctrlpvim/ctrlp.vim'                 " search fuzzy
Plugin 'derekwyatt/vim-fswitch'             " switch between companion files
Plugin 'embear/vim-localvimrc'              " search local vimrc files
Plugin 'ervandew/supertab'
Plugin 'gilsondev/searchtasks.vim'          " search TODO/FIXME
Plugin 'godlygeek/tabular'                  " align text
Plugin 'junegunn/goyo.vim'                  " write distraction-free
Plugin 'lifecrisis/vim-difforig'            " show unsaved buffer changes
Plugin 'majutsushi/tagbar'                  " display tags in a window
Plugin 'powerman/vim-plugin-ansiesc'        " conceal ansi sequences
Plugin 'preservim/nerdtree'                 " explore file system
Plugin 'preservim/nerdcommenter'            " comment in/out lines
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'vim-scripts/languagetool'           " proof-read

" generic programming support
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'               " check syntax
Plugin 'universal-ctags/ctags'

" c/c++
Plugin 'rhysd/vim-clang-format'             " check syntax/style for C++
Plugin 'xavierd/clang_complete'             " complete C/C++ code

" python
Plugin 'psf/black'

" jenkins
Plugin 'martinda/jenkinsfile-vim-syntax'    " support Jenkins

" docker
Plugin 'ekalinin/dockerfile.vim'            " highlight Dockerfile

" julia
Plugin 'juliaeditorsupport/julia-vim'       " support Julia

" markdown/text
Plugin 'reedes/vim-pencil'                  " allow soft-wrap
Plugin 'tpope/vim-markdown'                 " highlight syntax for Markdown
Plugin 'jtratner/vim-flavored-markdown'     " allow GitHub flavored markdown

" python
Plugin 'nvie/vim-flake8'                    " check syntax/style for Python

" swig
Plugin 'vim-scripts/swig-syntax'            " highlight SWIG

call vundle#end()
" --------------------------------------------------------

" Nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500

set fileencodings=utf8,cp1251,cp866,koi8-r

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

" Do not insert two spaces after '.', '?', '!' when joining
set nojoinspaces

" set persistent undo
" set undofile
set undodir=$HOME/.vim/undo  " must exist

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

" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
if &term =~ '256color'
    set t_ut=
endif

" Use the cool tab complete menu
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.o,*~,Makefile.in,*.a,*.la,*.dvi,*.aux
set wildignorecase
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
    filetype plugin indent on
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
if has("clipboard")
  set clipboard=unnamed         " copy to the system clipboard
  if has("unnamedplus")         " X11 support
    set clipboard+=unnamedplus
  endif
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

" Change autocompletion popup menu colors
highlight Pmenu ctermbg=gray guibg=gray
highlight PmenuSel ctermbg=lightgreen guibg=lightgreen
"

" ------------------------ Scripts configuration ------------------------
" tabular
vnoremap ,= :Tabularize /=<CR>

" clang complete
let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'

" CtrlP
noremap ,t :CtrlP<CR>
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_root_markers = ['.ctrlp']   " root CtrlP within the directory

" flake8
let g:flake8_cmd="flake8"

" Goyo
let g:goyo_width = 100

" Markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Livedown
let g:livedown_browser = "firefox"

" localvimrc
let g:localvimrc_name    = ".local_vimrc"
let g:localvimrc_ask     = 0
let g:localvimrc_sandbox = 0
let g:localvimrc_event   = [ "VimEnter", "BufReadPre", "BufNewFile" ]

" Makeshift tries the built file in the current directory before searching
" from the file directory.
let g:makeshift_use_pwd_first = 1

" NerdCommenter
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
map <F3>    <plug>NERDCommenterComment
map <F4>    <plug>NERDCommenterUncomment

" SuperTab
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabClosePreviewOnPopupClose = 1

" Syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs  = 1

" UltiSnips
let g:UltiSnipsSnippetDirectories  = ["snips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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
