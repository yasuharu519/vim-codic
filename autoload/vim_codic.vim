"=============================================================================
" FILE: autoload/vim_codic.vim
" AUTHOR: Yasuharu Sawada <yasuharu519@gmail.com>
" Last Change: 2015 Oct 18
" License: MIT license
"=============================================================================

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:version = 0.1

let s:V = vital#of('vim_codic')

let s:JSON = s:V.import('Web.JSON')
let s:HTML = s:V.import('Web.HTML')
let s:HTTP = s:V.import('Web.HTTP')
let s:Message = s:V.import('Vim.Message')

" url
let s:endpoint = 'https://api.codic.jp'

" APIs
let s:translate_api = '/v1/engine/translate.json'

if !exists('g:vim_codic_access_token')
    echo "Error: g:vim_codic_access_token is not set"
    finish
endif

let g:vim_codic_casing = get(g:, 'vim_codic_casing', 'camel')
function! vim_codic#check_codic_casing()
    let l:casing = g:vim_codic_casing
    if !(l:casing ==# "camel" || l:casing ==# "pascal" || l:casing ==# "lower underscore" || l:casing ==# "upper underscore" || l:casing ==# "hyphen")
        call s:Message.error("Error: " . g:vim_codic_casing . " is not supported as casing type.")
        return 0
    endif
    return 1
endfunction

" Check codic is valid
let s:is_codic_valid = vim_codic#check_codic_casing()
if !s:is_codic_valid
    finish
endif

function! vim_codic#version()
    return s:vesion
endfunction

function! vim_codic#error_msg(msg)
    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction

function! vim_codic#get_translated_text(text)
    let header = {
                \ 'User-Agent' : 'vim',
                \ 'Authorization' : 'Bearer ' . g:vim_codic_access_token }
    let data = {
                \ 'text' : a:text,
                \ 'casing' : g:vim_codic_casing }
    try
        let response = s:HTTP.get(s:endpoint . s:translate_api, data, header)
    catch /.*/
        call s:Message.error(v:exception)
        return ""
    endtry

    if response.status != 200
        call s:Message.error(response.statusText)
        return ""
    endif

    let s = response.content
    try
        let json = s:JSON.decode(s)
    catch /.*/
        return ""
    endtry

    if exists('json[0]["successful"]') && json[0]['successful']
        if exists("json[0]['translated_text']")
            return json[0]["translated_text"]
        endif
    endif

    return ""
endfunction

function! vim_codic#translate()
    let text = input("Input: ")
    let pos = getpos('.')
    execute ":normal i" . vim_codic#get_translated_text(text)
    call setpos('.', pos)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

