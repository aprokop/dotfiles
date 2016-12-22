setlocal cindent
setlocal cinoptions+=g0,p2s,i2s,+2s,j1,(0
setlocal noignorecase
setlocal noinfercase
setlocal foldenable
setlocal foldmethod=indent

vnoremap <buffer> ,= :Align=<CR>

" Auto remove white space when saving
" autocmd BufWritePre *.cc *.h :%s/\s\+$//e
" autocmd BufEnter    *.cc *.h :%s/[ \t\r]\+$//e

" Easily switch between source and header file
au! BufEnter *.c let b:fswitchdst = 'h' | let b:fswitchlocs = '../inc'
au! BufEnter *.h let b:fswitchdst = 'c' | let b:fswitchlocs = '../inc'
nmap ,s :FSHere<CR>

" automatic __HEADER_H__ generation for new .h files
function! <SID>insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef __" . gatename . "__"
    execute "normal! o#define __" . gatename . "__"
    :put=''
    :put=''
    execute "normal! Go#endif // __" . gatename . "__"
    normal! 2k
endfunction
autocmd BufNewFile *.h call <SID>insert_gates()

function! <SID>make_local()
    wa
    let cur_dir = getcwd()
    lcd %:h
    make
    exe "lcd" . cur_dir
    cw
endfunction

au QuickFixCmdPre make wall
au QuickFixCmdPost make cw
noremap <buffer> <F5> :update<CR>:make<CR><CR>
noremap <buffer> <S-F5> :update<CR>:call <SID>make_local()<CR><CR>

" For some reason, Syntastic does not work properly with c files for me
" This is a workaround for that
au! BufWritePost *.c,*.h SyntasticCheck gcc
