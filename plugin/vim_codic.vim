scriptencoding utf-8
if exists('g:loaded_vim_codic') && g:loaded_vim_codic
    finish
endif
let g:loaded_vim_codic = 1

let s:save_cpo = &cpo
set cpo&vim

command! VimCodic :call vim_codic#translate()

let &cpo = s:save_cpo
unlet s:save_cpo
