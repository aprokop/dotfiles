" comments
noremap <silent> <F3> :s/^\(\s*\)/\1%\ /<CR>
noremap <silent> <F4> :s/^\(\s*\)%\ /\1/<CR>

" set formatoptions=a

let b:pagenumber=0
noremap <F5> :w<CR>:!latex --output-directory=.out "%" ; latex --output-directory=.out "%" ; dvips .out/"%:r".dvi -o "%:r".ps<CR><CR>
" noremap <F5> :w<CR>:!latex --output-directory=.out "%" ; dvips .out/"%:r".dvi -o "%:r".ps<CR><CR>
noremap <S-F5> :w<CR>:!latex --output-directory=.out "%" ; cd .out ; bibtex "%:r" ; cd .. ; latex --output-directory=.out "%" ; latex --output-directory=.out "%" ; dvips .out/"%:r".dvi -o "%:r".ps<CR><CR>

set textwidth=150

" iabbrev <buffer> beeq \begin{equation}<Enter>
" iabbrev <buffer>  eeq \end{equation}<Enter>
