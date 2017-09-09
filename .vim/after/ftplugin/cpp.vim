runtime c.vim

iabbrev <buffer> jci const_iterator
iabbrev <buffer> jit iterator
iabbrev <buffer> jns namespace
iabbrev <buffer> jpr private
iabbrev <buffer> jpu public
iabbrev <buffer> jpro protected
iabbrev <buffer> jsc std::cout <<
iabbrev <buffer> jse std::endl
iabbrev <buffer> jsl std::list
iabbrev <buffer> jsm std::map
iabbrev <buffer> jso std::ostream
iabbrev <buffer> jss std::string
iabbrev <buffer> jsv std::vector
iabbrev <buffer> jsp std::pair
iabbrev <buffer> jssh std::tr1::shared_ptr
iabbrev <buffer> jty typedef
iabbrev <buffer> jun using namespace
iabbrev <buffer> jvi virtual

" Easily switch between source and header file
au! BufEnter *.C,*.cc,*.cpp,*.cxx let b:fswitchdst = 'h,hh,H,hpp,hxx'
au! BufEnter *.h,*.H,*.hpp,*.hxx  let b:fswitchdst = 'cc,cpp,cxx,C,c'
nmap ,s :FSHere<CR>
