" Comment/uncomment
noremap <silent> <buffer> <F3> :s/^\(\s*\)\([^>]*\)>\(\s*<\?.*\)$/\1<!--\ \2> -->\3/<CR>
noremap <silent> <buffer> <F4> :s/^\(\s*\)<!--\ \([^>]*\)>\ -->\(.*\)$/\1\2>\3/<CR>
