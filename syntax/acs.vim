" Vim syntax file
" Language:	acs
" Author:	PROPHESSOR <xenteze@gmail.com>

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet acs_fold

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'acs'
elseif exists("b:current_syntax") && b:current_syntax == "acs"
  finish
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("acs_fold")
  unlet acs_fold
endif

syntax case ignore

syn match   acsLineComment      "\/\/.*" contains=@Spell,acsCommentTodo
syn match   acsCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn match   acsSpecial	       "\\\d\d\d\|\\."
syn match   acsSpecialCharacter "'\\.'"
syn match   acsNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match   acsTypeModifier     /[sif]:/
syn match   acsPreprocessor     /#include/
syn match   acsPreprocessor     /#library \w\+/
syn match   Float /\d\+\(\.\d\)\=/ "TODO: acsNumber
syn match   Function /\w\+\((\)\@=/

syn region  acsComment	       start="/\*"  end="\*/" contains=@Spell,acsCommentTodo fold
syn region  acsString           start=/"/ end=/"/ skip=/\\"/ contains=acsCommentTodo fold

"syn keyword acsPreprocessor #include #libraray
syn keyword acsCommentTodo  TODO FIXME XXX TBD contained
syn keyword acsConditional	if else switch
syn keyword acsRepeat		while for do
syn keyword acsBranch		break continue
syn keyword acsType	        int bool str float void
syn keyword acsStatement	return function script
syn keyword acsBoolean		true false
syn keyword acsNull		    null
syn keyword acsIdentifier	OFF OPEN ENTER DEATH RESPAWN
syn keyword acsLabel		case default
syn keyword acsException	try catch
syn keyword acsMessage		print
syn keyword acsGlobal		self window top parent
syn match acsMember 		/Sector_\w\+/
syn match acsMember        /Level_\w\+/
syn match acsMember        /Door_\w\+/
syn match acsMember        /Floor_\w\+/
syn match acsMember        /Ceiling_\w\+/
syn match acsMember        /HUD_\w\+/
syn match acsMember        /ACS_\w\+/
syn keyword acsReserved		const 

if exists("acs_fold")
    syn match	acsScript	"\<function\>"
    syn region	acsScriptFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match acsSync	grouphere acsScriptFold "\<function\>"
    syn sync match acsSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword acsScript	Script
    syn match	acsBraces	   "[{}\[\]]"
    syn match	acsParens	   "[()]"
endif

syn sync fromstart

if main_syntax == "acs"
  syn sync ccomment acsComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_acs_syn_inits")
  if version < 508
    let did_acs_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command! -nargs=+ HiLink hi def link <args>
  endif
  HiLink acsComment		    Comment
  HiLink acsLineComment		Comment
  HiLink acsPreprocessor	PreProc
  HiLink acsCommentTodo		Todo
  HiLink acsSpecial		    Special
  HiLink acsStringS		    String
  HiLink acsStringD		    String
  HiLink acsString          String
  HiLink acsCharacter		Character
  HiLink acsSpecialCharacteracs Special
  HiLink acsNumber		    Float
  HiLink acsConditional		Conditional
  HiLink acsRepeat		    Repeat
  HiLink acsBranch	    	Conditional
  HiLink acsOperator		Operator
  HiLink acsType			Type
  HiLink acsTypeModifier	Type
  HiLink acsStatement		Statement
  HiLink acsFunction		Function
  HiLink acsBraces		    Function
  HiLink acsError		    Error
  HiLink acsNull			Keyword
  HiLink acsBoolean	        Boolean
  HiLink acsRegexpString	String

  HiLink acsIdentifier  	Identifier
  HiLink acsLabel	    	Label
  HiLink acsException   	Exception
  HiLink acsMessage	    	Keyword
  HiLink acsGlobal		    Keyword
  HiLink acsMember  		Keyword
  HiLink acsReserved	    Keyword
  HiLink acsConstant	    Label

  delcommand HiLink
endif

let b:current_syntax = "acs"
if main_syntax == 'acs'
  unlet main_syntax
endif
