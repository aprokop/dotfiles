" funcsrch.vim:
"   Function: perform a search restricted to a function whose extents
"             can be determined by [[ and ][.  These may in turn be
"             defined by the user via maps.
"
"   Version:  2a		ASTRO-ONLY
"   Date:     Jan 25, 2006
"   Usage:    :FS  pattern       (search forwards for pattern)
"             :FSB pattern       (search backwards for pattern)
"             :FS                (re-use last search pattern, forward search)
"             :FSB               (re-use last search pattern, backward search)
" Copyright:    Copyright (C) 2005 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like anything else that's free,
"               funcsrch.vim is provided *as is* and comes with no warranty
"               of any kind, either expressed or implied. By using this
"               plugin, you agree that in no event will the copyright
"               holder be liable for any damages resulting from the use
"               of this software.
"
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("g:loaded_funcsrch")
 finish
endif
let s:keepcpo= &cpo
let g:loaded_funcsrch= "v2a"
set cpo&vim

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com! -nargs=? FS  call s:FuncSrch(1,<q-args>)
com! -nargs=? FSB call s:FuncSrch(2,<q-args>)
com! -nargs=1 FR  call s:FuncSub(1,<q-args>)
com! -nargs=1 FRg call s:FuncSub(2,<q-args>)

" ---------------------------------------------------------------------
" FuncSrch: {{{1
fun! s:FuncSrch(dir,pat)
"  call Dfunc("FuncSrch(dir=".a:dir." pat<".a:pat.">)")
  let pat= a:pat

  " allow no argument to result in a prompt
  if pat == ""
   if b:funcsrch_srch == @/
   	let pat= b:funcsrch_pat
   else
    let pat= @/
   endif
  endif
  let b:funcsrch_pat  = pat
  let swp             = SaveWinPosn(0)
  norm [[
  let funcstart       = line(".") - 1
  norm ][
  let funcstop        = line(".") + 1
  let srch            = '\%(\%>'.funcstart.'l\%<'.funcstop.'l\)\&'.pat
  let b:funcsrch_srch = srch
  call RestoreWinPosn(swp)
  if a:dir == 1
   call search(srch)
  else
   call search(srch,'b')
  endif
  let @/= srch
"  call Dret("FuncSrch")
endfun

" ---------------------------------------------------------------------
"  Modelines: {{{1
"  vim: fdm=marker ts=4
let &cpo= s:keepcpo
unlet s:keepcpo
