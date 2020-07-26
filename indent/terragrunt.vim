if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

" Set to 2 space tabs
setlocal autoindent shiftwidth=2 tabstop=2 softtabstop=2

" cindent seems to work adequately with HCL's brace-y syntax
" Courtesy of github.com/b4b4r07/vim-hcl
setlocal cindent

" don't de-indent comments (cindent treats them like preprocessor directives)
setlocal cinkeys-=0#
