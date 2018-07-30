" Vim syntax file
" Language:	sndinfo
" Author:	PROPHESSOR <xenteze@gmail.com>

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet sndinfo_fold

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'sndinfo'
elseif exists("b:current_syntax") && b:current_syntax == "sndinfo"
  finish
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("sndinfo_fold")
  unlet sndinfo_fold
endif

syntax case ignore
setlocal iskeyword+=$

syn match   Comment      "\/\/.*" contains=@Spell,Todo
syn match   Comment      "^[ \t]*\*\($\|[ \t]\+\)"
syn match   Number	     "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match   Float        /\b\d\+\(\.\d\)\=\b/
syn match   Float        /\b\d\+\(\x\[0-9A-Fa-f]\+\)\=\b/             "TODO: sndinfoNumber
syn match   VisualNOS    /[\s\n]\@=\s\@<=\([.A-Za-z0-9_-]\+\)\/\(.\+\)/ " weapons/test
syn match   Identifier     /*[a-z0-9]\+/

syn region  Comment	     start="/\*"  end="\*/" contains=@Spell,Todo fold
syn region  String       start=/"/ end=/"/ skip=/\\"/ contains=Todo fold

syn keyword Todo         TODO FIXME XXX TBD contained
syn keyword Statement    $alias $ambient $archivepath $attenuation $edfoverride $ifdoom $ifheretic $ifhexeni $ifstrife $limit $map $mididevice $musicalias $musicvolume $pitchshift $pitchshiftrange $playeralias $playercompat $playersound $playersounddup $random $registered $rolloff $singular $volume
syn keyword Type        male female other

set foldmethod=indent

syn sync fromstart

if main_syntax == "sndinfo"
  syn sync ccomment sndinfoComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sndinfo_syn_inits")
  if version < 508
    let did_sndinfo_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command! -nargs=+ HiLink hi def link <args>
  endif

  delcommand HiLink
endif

let b:current_syntax = "sndinfo"
if main_syntax == 'sndinfo'
  unlet main_syntax
endif

" Default file associations
au BufRead,BufNewFile SNDINFO set filetype=sndinfo
au BufRead,BufNewFile SNDINFO.* set filetype=sndinfo
