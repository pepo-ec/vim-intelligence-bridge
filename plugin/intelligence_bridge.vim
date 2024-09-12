if exists('g:loaded_intelligence_bridge') | finish | endif
let g:loaded_intelligence_bridge = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:intelligence_bridge_map')
    let g:intelligence_bridge_map = '<Leader>ib'
endif

execute 'vnoremap <silent> ' . g:intelligence_bridge_map . ' :call intelligence_bridge#process()<CR>'

let &cpo = s:save_cpo
unlet s:save_cpo

