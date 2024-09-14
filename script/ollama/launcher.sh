#!/bin/bash

LARAVEL_FILL_FILE="$HOME/.vim/plugged/vim-intelligence-bridge/script/code/laravel/prompt.txt"
LARAVEL_DEVEL_FILE="$HOME/.vim/plugged/vim-intelligence-bridge/script/code/laravel/devel.txt"
LARAVEL_SYSTEM_FILE="$HOME/.vim/plugged/vim-intelligence-bridge/script/code/laravel/system.txt"

TMP_FILE=""
SYSTEM=""
GUIDE=""

# Función para leer el archivo .env
leer_env() {
    local ruta_env="$HOME/.vim/plugged/vim-intelligence-bridge/config.env"
    if [ -f "$ruta_env" ]; then
        source "$ruta_env"
        if [ -z "$OLLAMA_MODEL" ]; then
            echo "La variable OLLAMA_MODEL no está definida en el archivo $ruta_env"
            exit
        fi
    else
        echo "El archivo $ruta_env no existe"
        exit
    fi
}

call_ollama() {
    ollama run "$OLLAMA_MODEL" """
    $SYSTEM
    
    $GUIDE
    
    El archivo sobre el que vas a trabajar es el siguiente:
    
    $(cat $TMP_FILE)
    """
}

# Verificar el número de parámetros
if [ $# -ne 2 ]; then
    echo "Error: Este script requiere exactamente dos parámetros."
    echo "Uso: $0 <parametro1> <parametro2>"
    exit
fi

leer_env

# Verificar el valor del primer parámetro
if [ "$1" = "00" ]; then
    SYSTEM=$(cat "$LARAVEL_SYSTEM_FILE" | sed -e 's/"/\\"/g' -e 's/\$/\\$/g' | awk '{printf "%s\\n", $0}')
    GUIDE=$(cat "$LARAVEL_DEVEL_FILE" | sed -e 's/"/\\"/g' -e 's/\$/\\$/g' | awk '{printf "%s\\n", $0}')
    TMP_FILE="$2"
else
    echo "Error de modo"
    exit
fi

call_ollama
