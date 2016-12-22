noremap <buffer> <F5> :up<CR>:!clear && tclsh "%"<CR>
noremap <buffer> <S-F5> :up<CR>:!clear && wish "%"<CR>
" as I often miss S-F5 and get S-F4, which erases line, so ...
noremap <buffer> [1;2S :up<CR>:!clear && wish "%"<CR>

setlocal keywordprg=man\ -S\ n:3
