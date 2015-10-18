"=============================================================================
" FILE: plugin/vim_codic.vim
" AUTHOR: Yasuharu Sawada <yasuharu519@gmail.com>
" Last Change: 2015 Oct 18
" License: MIT license
"=============================================================================

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
