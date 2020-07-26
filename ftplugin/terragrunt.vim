" terragrunt.vim - basic vim/terragrunt integration
" Maintainer: yorinasub17 <https://github.com/yorinasub17>

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

let b:undo_ftplugin = ""

let &cpo = s:save_cpo
unlet s:save_cpo
