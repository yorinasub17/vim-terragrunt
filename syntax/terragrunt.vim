" Since terragrunt uses hcl, we fork the syntax file from terraform and adapt it
" github.com/hashivim/vim-terraform

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Identifiers are made up of alphanumeric characters, underscores, and
" hyphens.
if has('patch-7.4.1142')
    syn iskeyword a-z,A-Z,48-57,_,-
endif

syn case match

" A block is introduced by a type, some number of labels - which are either
" strings or identifiers - and an opening curly brace.  Match the type.
syn match tgBlockIntroduction /^\s*\zs\K\k*\ze\s\+\(\("\K\k*"\|\K\k*\)\s\+\)*{/ contains=tgBlockType
" TODO: autogenerate from terragrunt struct
syn keyword tgBlockType contained locals include remote_state dependencies dependency generate terraform

syn keyword tgValueBool true false on off yes no

" Terragrunt attributes, which are top level assignments of keywords
syn match tgAttribute  /^\s*\zs\K\k*\ze\s\+=/ contains=tgAttrType
" TODO: autogenerate from terragrunt struct
syn keyword tgAttrType contained terraform_binary terraform_version_constraint terragrunt_version_constraint inputs download_dir prevent_destroy skip iam_role

syn keyword tgTodo         contained TODO FIXME XXX BUG TF-UPGRADE-TODO
syn region  tgComment      start="/\*" end="\*/" contains=tgTodo,@Spell
syn region  tgComment      start="#" end="$" contains=tgTodo,@Spell
syn region  tgComment      start="//" end="$" contains=tgTodo,@Spell

""" misc.
syn match tgValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match tgValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match tgBraces        "[\[\]]"

""" skip \" and \\ in strings.
syn region tgValueString   start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=tgStringInterp
syn region tgStringInterp  matchgroup=tgBraces start=/\${/ end=/}/ contained contains=ALL
syn region tgHereDocText   start=/<<-\?\z([a-z0-9A-Z]\+\)/ end=/^\s*\z1/ contains=tgStringInterp

"" Functions.
syn match tgFunction "[a-z0-9_]\+(\@="

""" HCL2
syn keyword tgRepeat         for in
syn keyword tgConditional    if
syn keyword tgValueNull      null

" enable block folding
syn region tgBlockBody matchgroup=tgBraces start="{" end="}" fold transparent

hi def link tgComment           Comment
hi def link tgTodo              Todo
hi def link tgBraces            Delimiter
hi def link tgBlockType         Structure
hi def link tgAttrType          Identifier
hi def link tgValueBool         Boolean
hi def link tgValueDec          Number
hi def link tgValueHexaDec      Number
hi def link tgValueString       String
hi def link tgHereDocText       String
hi def link tgFunction          Function
hi def link tgRepeat            Repeat
hi def link tgConditional       Conditional
hi def link tgType              Type
hi def link tgValueNull         Constant

let b:current_syntax = "terragrunt"

let &cpo = s:cpo_save
unlet s:cpo_save
