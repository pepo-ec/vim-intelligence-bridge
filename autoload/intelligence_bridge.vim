let s:save_cpo = &cpo
set cpo&vim

function! intelligence_bridge#process() range
    " Pide al usuario que ingrese el parámetro
    let param = input('Ingrese el parámetro para Intelligence Bridge: ')
    if param == ''
        echo "Operación cancelada."
        return
    endif

    " Crea un archivo temporal para la entrada
    let input_file = tempname()
    " Crea un archivo temporal para la salida
    let output_file = tempname()

    " Guarda la selección actual en el archivo temporal de entrada
    execute "silent" a:firstline "," a:lastline "write!" input_file

    " Obtiene la ruta del script
    " let script_path = expand('<sfile>:p:h:h') . '/script/intelligence_bridge.sh'
    let script_path = expand('~/.vim/plugged/vim-intelligence-bridge/script/intelligence_bridge.sh')

    " Ejecuta el script de Bash
    let cmd = shellescape(script_path) . ' ' . shellescape(param) . ' < ' . shellescape(input_file) . ' > ' . shellescape(output_file)
    let result = system(cmd)

    " Verifica si hubo algún error
    if v:shell_error
        echohl ErrorMsg
        echo "Error ejecutando Intelligence Bridge: " . result
        echohl None
    else
        " Abre un split vertical con el archivo de salida
        execute 'vnew ' . fnameescape(output_file)
        setlocal buftype=nofile bufhidden=delete noswapfile readonly
    endif

    " Limpia los archivos temporales
    call delete(input_file)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
