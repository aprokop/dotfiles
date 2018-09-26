let b:pagenumber=0

noremap <buffer> <F5> :update<CR>:Make<CR><CR>

" Set indentation
setlocal sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
setlocal iskeyword+=:

" Add easy align
vnoremap ,& :Align&<CR>

" Spell sometimes does not work properly in TeX files. This is a hack to
" make it more robust.
syn sync minlines=500
syn sync maxlines=2000
