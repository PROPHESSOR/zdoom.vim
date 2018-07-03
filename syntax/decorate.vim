
" Vim syntax file
" Language:	decorate
" Author:	PROPHESSOR <xenteze@gmail.com>

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet decorate_fold

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'decorate'
elseif exists("b:current_syntax") && b:current_syntax == "decorate"
  finish
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("decorate_fold")
  unlet decorate_fold
endif

syntax case ignore

syn match   decorateLineComment      "\/\/.*" contains=@Spell,decorateCommentTodo
syn match   decorateCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn match   decorateSpecial	       "\\\d\d\d\|\\."
syn match   decorateSpecialCharacter "'\\.'"
syn match   decorateNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match   decorateTypeModifier    /[sif]:/
syn match   decoratePreprocessor    /#include/
syn match   decoratePreprocessor    /#library \w\+/
syn match   Float                   /\d\+\(\.\d\)\=/                         "TODO: decorateNumber
syn match   Float                   /\d\+\(\x\[0-9A-Fa-f]\+\)\=/             "TODO: decorateNumber
syn match   Function                /\w\+\((\)\@=/
syn match   decorateStateAction     /GoTo\s\+[A-Za-z0-9.]\+/
syn match   decorateState           /[A-Za-z0-9.]\+:/
syn match   decorateSprite          /[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]\s\+[A-Z]\+/
syn match   decorateProperty        /Player\.\w\+/
syn match   decorateProperty        /Inventory\.\w\+/
syn match   decorateProperty        /Weapon\.\w\+/
syn match   decorateProperty        /[+]\w\+/
syn match   decorateProperty        /-\w\+/
syn match   Function                /A_\w\+/
syn match   Tag                     /user_\w\+/

syn region  decorateComment	       start="/\*"  end="\*/" contains=@Spell,decorateCommentTodo fold
syn region  decorateString         start=/"/ end=/"/ skip=/\\"/ contains=decorateCommentTodo fold

syn keyword decorateCommentTodo  TODO FIXME XXX TBD contained
syn keyword decorateConditional	A_JumpIf
"syn keyword decorateRepeat		while for do
syn keyword decorateBranch		replaces
syn keyword decorateType	    int float
syn keyword decorateStatement	var
"syn keyword decorateBoolean		true false
"syn keyword decorateNull		null
syn keyword decorateStateAction	Stop Loop
syn keyword decorateLabel		Actor States
"syn keyword decorateException	try catch
"syn keyword decorateMessage		print
"syn keyword decorateGlobal		self window top parent
"syn keyword decorateMember		Sector_ Level_ Door_ Floor_ Ceiling_ HUD_
"syn keyword decorateReserved		.

set foldmethod=indent

if exists("decorate_fold")
    syn match	decorateScript	"\<function\>"
    syn region	decorateScriptFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword decorateScript	Script
    syn match	decorateBraces	   "[{}\[\]]"
    syn match	decorateParens	   "[()]"
endif

syn sync fromstart

if main_syntax == "decorate"
  syn sync ccomment decorateComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_decorate_syn_inits")
  if version < 508
    let did_decorate_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command! -nargs=+ HiLink hi def link <args>
  endif

  HiLink decorateProperty           Structure
  HiLink decorateSprite             Tag
  HiLink decorateState              Macro
  HiLink decorateComment		    Comment
  HiLink decorateLineComment		Comment
  HiLink decoratePreprocessor   	Comment
  HiLink decorateCommentTodo		Todo
  HiLink decorateSpecial		    Special
  HiLink decorateStringS		    String
  HiLink decorateStringD		    String
  HiLink decorateString             String
  HiLink decorateCharacter		    Character
  HiLink decorateSpecialCharacterdecorate Special
  HiLink decorateNumber		        Float
  HiLink decorateConditional		Conditional
  HiLink decorateRepeat		        Repeat
  HiLink decorateBranch	    	    Conditional
  HiLink decorateOperator		    Operator
  HiLink decorateType			    Type
  HiLink decorateTypeModifier	    Type
  HiLink decorateStatement		    Statement
  HiLink decorateFunction		    Function
  HiLink decorateBraces		        Function
  HiLink decorateError		        Error
  HiLink decorateNull			    Keyword
  HiLink decorateBoolean	        Boolean
  HiLink decorateRegexpString	    String

  HiLink decorateStateAction  	Identifier
  HiLink decorateLabel	    	Function
  HiLink decorateException   	Exception
  HiLink decorateMessage	    Keyword
  HiLink decorateGlobal		    Keyword
  HiLink decorateMember  		Keyword
  HiLink decorateReserved	    Keyword
  HiLink decorateConstant	    Label

  delcommand HiLink
endif

let b:current_syntax = "decorate"
if main_syntax == 'decorate'
  unlet main_syntax
endif
