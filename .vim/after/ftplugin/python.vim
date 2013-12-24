noremap <buffer> <F5> :up<CR>:!clear && python "%"<CR>

" Comment/uncomment
noremap <silent> <buffer> <F3> :s/^\(\s*\)/\1#\ /<CR>
noremap <silent> <buffer> <F4> :s/^\(\s*\)#\ /\1/<CR>

setlocal keywordprg=man\ -S\ n:3
setlocal shiftwidth=4
