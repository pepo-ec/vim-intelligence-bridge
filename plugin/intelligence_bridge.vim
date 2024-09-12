if exists('g:loaded_intelligence_bridge') | finish | endif
let g:loaded_intelligence_bridge = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:intelligence_bridge_map')
    let g:intelligence_bridge_map = '<Leader>ib'
endif

" Asignar permisos de ejecución al script
let s:script_path = expand('~/.vim/plugged/vim-intelligence-bridge/script/intelligence_bridge.sh')
if filereadable(s:script_path)
    if has('win32') || has('win64')
        " Windows no necesita cambiar permisos
    else
        silent! execute '!chmod +x ' . shellescape(s:script_path)
    endif
endif

execute 'vnoremap <silent> ' . g:intelligence_bridge_map . ' :call intelligence_bridge#process()<CR>'

let &cpo = s:save_cpo
unlet s:save_cpo

