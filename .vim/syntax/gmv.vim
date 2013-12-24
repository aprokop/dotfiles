" Vim syntax file
" Language:	GMV syntax highlighting
" Maintainer:	Andrey Prokopenko <andrey.prok@gmail.com>
" Last Change:	$Date: 2008/07/29 13:25:17 $
" Filenames:	*.gmv

if exists("b:current_syntax")
  finish
endif

syn keyword edpType		gmvinput endgmv
syn keyword edpType		nodes nodev faces

hi def link edpType		Type

let b:current_syntax = "gmv"
