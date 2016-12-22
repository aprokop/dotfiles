" Vim syntax file
" Language:	FreeFem++
" Maintainer:	Andrey Prokopenko <andrey.prok@gmail.com>
" Last Change:	$Date: 2007/04/27 13:25:17 $
" Filenames:	*.edp
" TODO:		freefem++-2.16/src/ide/highlight.cpp contains list of all reserved words to
"		highlight, need to get context in which they are used to highlight appropriately

if exists("b:current_syntax")
  finish
endif

" General keywords
syn keyword edpStatement	continue break return end
syn keyword edpConditional	if else
syn keyword edpException	try catch throw
syn keyword edpRepeat		while for
syn keyword edpConstant		pi
syn keyword edpBoolean		true false


syn keyword edpType		bool int real string complex
syn keyword edpType		ofstream ifstream
syn keyword edpType		func mesh fespace problem solve varf matrix border
syn keyword edpMacro		macro


syn keyword edpGlobal		HaveUMFPACK NoUseOfWait
syn keyword edpGlobal		x y z
" We don't want to highlight smth like var.x or var.y
syn match   edpNONE		"\.x"
syn match   edpNONE		"\.y"
syn match   edpNONE		"\.z"
syn keyword edpGlobal		dx dy dxx dxy dyx dyy
syn keyword edpGlobal		P N
syn keyword edpGlobal		lenEdge hTriangle nuTriangle nuEdge hTonEdge
syn keyword edpGlobal		region
syn keyword edpGlobal		cout cin endl
syn keyword edpGlobal		CG Cholesky Crout GMRES LU LinearCG BFGS UMFPACK Crout
syn keyword edpGlobal		P P0 P0edge P1 P1b P1dc P1nc P2 P2b P2dc P2h RT0 RT0Ortho
syn keyword edpGlobal		qf1pE qf1pT qf1pTlump qf2pE qf2pT qf2pT4P1 qf3pE qf5pT

syn keyword edpLabel		anisomax cmm eps factorize fill init inquire IsMetric
syn keyword edpLabel		label maxit nbvx ncv qfnbpE qforder ps
syn keyword edpLabel		sigma solver splitbedge sym tgv tol tolpivot value verbosity vector viso wait

syn keyword edpInclude		include

syn keyword edpFunc		pow exp log log10 sqrt
syn keyword edpFunc		sin cos tan asin acos atan atan2
syn keyword edpFunc		sinh cosh tanh asinh acosh atanh
syn keyword edpFunc		floor ceil rint
syn keyword edpFunc		randint32 randint31 randreal1 randreal2 randreal3 randres53 randinit
syn keyword edpFunc		min max abs
" We don't want to highlight smth like var.min or var.max
syn match edpNONE		"\.min"
syn match edpNONE		"\.max"

syn keyword edpFunc		dumptable exec assert exit clock

syn keyword edpFunc		interpolate
syn keyword edpFunc		readmesh savemesh
syn keyword edpFunc		adaptmesh buildmesh buildmeshborder movemesh checkmovemesh splitmesh emptymesh
syn keyword edpFunc		int1d int2d	intalledges jump on otherside
syn keyword edpFunc		EigenValue convect
syn keyword edpFunc		square
syn keyword edpFunc		norm plot

syn keyword edpModifier		precision scientific " ofstream modifiers


syn keyword edpTODO		contained TODO FIXME XXX

syn cluster edpCommentGroup contains=edpTODO
syn region  edpComment		start="//"   end="$" contains=@edpCommentGroup
syn region  edpComment		start="/\*"  end="\*/" contains=@edpCommentGroup

syn region  edpString		start="\"" end="\""


hi def link edpMacro		Macro
hi def link edpGlobal		Special
hi def link edpModifier		Typedef
hi def link edpLabel		Special
hi def link edpType		Type
hi def link edpFunc		Function
hi def link edpConditional	Conditional
hi def link edpException	Exception
hi def link edpRepeat		Repeat
hi def link edpStatement	Statement
hi def link edpConstant		Constant
hi def link edpComment		Comment
hi def link edpString		String
hi def link edpInclude		Include
hi def link edpBoolean		Boolean
hi def link edpTODO		TODO

let b:current_syntax = "FreeFem++"
