" comments
noremap <silent> <F3> :s/^\(\s*\)/\1%\ /<CR>
noremap <silent> <F4> :s/^\(\s*\)%\ /\1/<CR>

" set formatoptions=a

let b:pagenumber=0

" function! <SID>make()
  " wa
  " !make
  " !latex --output-directory=.out "%"
  " !latex --output-directory=.out "%"
  " !cd .out
  " !bibtex "%:r"
  " !cd ..
  " !latex --output-directory=.out "%"
  " ! dvips .out/"%:r".dvi -o "%:r".ps
" endfunction

noremap <buffer> <F5> :update<CR>:Make<CR><CR>

set textwidth=80

" iabbrev <buffer> beeq \begin{equation}<Enter>
" iabbrev <buffer>  eeq \end{equation}<Enter>
