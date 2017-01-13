" Free source form (f90 and later)
let fortran_free_source=1

" Make syntax coloring more precise (but slower).
" In particular, statement labels used in do, goto and arithmetic if
" statements will be recognized, as will construct names at the end of a do,
" if, select or forall construct.
let fortran_more_precise=1

" Highlight beyond 77 characters for Fortran 77
" hi beyond_border ctermbg=red
" match beyond_border /\%>77v.*/
