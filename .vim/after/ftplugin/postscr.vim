noremap <buffer> <F5> :update<CR>:!gv "%"<CR>

" Comment/uncomment
noremap <silent> <buffer> <F3> :s/^\(\s*\)/\1%\ /<CR>		
noremap <silent> <buffer> <F4> :s/^\(\s*\)%\ /\1/<CR>

