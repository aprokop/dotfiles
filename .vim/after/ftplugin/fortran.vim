" Comment/uncomment
noremap <silent> <buffer> <F3> :s/^/c/<CR>		
noremap <silent> <buffer> <F4> :s/^c//<CR>

noremap <buffer> <F5> :wa<CR>:make<CR>:cw<CR>

" hi beyond_border ctermbg=red
" match beyond_border /\%>77v.*/
