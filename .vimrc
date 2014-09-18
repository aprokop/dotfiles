scriptencoding utf-8

" Don't be compatible with vi
set nocompatible

" Nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500

set fileencodings=utf8,cp1251,cp866,koi8-r

set term=xterm

set listchars=eol:$,tab:>-

" Shifts
set softtabstop=4
" By default, go for an indent of 4
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

" q: sucks
" nmap q: :q

noremap ,t :CtrlP<CR>
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_clear_cache_on_exit = 0

" Make <space> in normal mode go down a page rather than left a character
noremap <space> <C-f>

" Define language of file
set encoding=utf-8
set termencoding=utf-8

" более привычные Page Up/Down, когда курсор остаетс€ в той же строке,
" (а не переноситс€ в верх/низ экрана, как при стандартном)
" ѕоскольку по умолчанию прокрутка по C-Y/D происходит на полэкрана,
" прив€зка делаетс€ к двойному нажатиe
nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


" Group comments
if has("autocmd") && has("eval")
    " Add comment symbol in the beginning of the line
"    au BufEnter .vimrc,*.vim			noremap <F3> :s/^\(\s*\)/\1"\ /<CR>			" "
    au BufEnter configure.in,configure.ac	noremap <F3> :s/^\(\s*\)/\1\#\ /<CR>		" #
    " Remove comment symbol in the beginning of the line
"    au BufEnter .vimrc,*.vim			noremap <silent> <F4> :s/^\(\s*\)"\ /\1/<CR>		" "
    au BufEnter configure.in,configure.ac	noremap <silent> <F4> :s/^\(\s*\)\#\ /\1/<CR>		" #
endif

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" ≈сли скобка стоит не первым символом в строке
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

noremap <F6>  :ccl<CR> " Close make window
noremap <F7>  :cp<CR>  " Go to next error
noremap <F8>  :cn<CR>  " Go to prev error
" SVN
" noremap <F9>            :!svn diff   > .svn.diff<CR>:tabnew<CR>:view .svn.diff<CR>gg
" noremap <S-F9>          :!svn diff % > .svn.diff<CR>:tabnew<CR>:view .svn.diff<CR>gg
" git
noremap <F9>            :!git diff     > .git.diff<CR>:tabnew<CR>:view .git.diff<CR>gg
noremap <S-F9>          :!git diff "%" > .git.diff<CR>:tabnew<CR>:view .git.diff<CR>gg
noremap <F10>           :CalendarH<CR>
noremap <silent> <F11>  :cal VimCommanderToggle()<CR>
noremap <S-F12>         :!ctags -R -I THROW --c++-kinds=+p --fields=+iatS --extra=+q .<CR><CR>

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

" edit ~/.vimrc
nmap ,v :e ~/.vimrc<CR>
nmap ,s :source ~/.vimrc<CR>

" Insert a blank line below/above/after/prior and stay in normal mode
nnoremap ,o :put =''<CR>
nnoremap ,O :put! =''<CR>
nnoremap ,i i<space><Esc>
nnoremap ,a a<space><Esc>

" Luc Hermitte's C/C++ plugins let b:usemarks=""

" Set grep program to always generate a file-name
set grepprg=grep\ -nH\ $*

set langmap=жйучхбртыпмдшфэъклщезнгюос;ABCDEFGHIJKLMNOPQRSTUVWXYZ,∆…”„’Ѕ–“џѕћƒЎ‘ЁЏ Ћў≈«Ќ√ёќ—;abcdefghijklmnopqrstuvwxyz

set guicursor=a:block-Cursor-blinkon0

" Improve autocomplete menu color
highlight PmenuSel ctermbg=yellow gui=bold
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabRetainCompletionDuration = "session"

" Make scripts executable by default: if file begins with #! and contains '/bin/' in the path
" au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif

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
    endi
endfun
nnoremap ,w :call ChangeHighlightWhite()<CR>
if has("autocmd")
    au BufEnter * match ExtraWhitespace /\s\+$/
endif

" Run pathogen
execute pathogen#infect()

" " Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs  = 1

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
	let @e = substitute (@e, '\csin\s*(', "s (", "")
	let @e = substitute (@e, '\ccos\s*(', "c (", "")
	let @e = substitute (@e, '\catan\s*(', "a (", "")
	let @e = substitute (@e, "\cln\s*(", "l (", "")

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
