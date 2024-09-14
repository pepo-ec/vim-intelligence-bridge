#!/bin/bash

# Nombre del script: intelligence_bridge.sh

# Verificamos si se ha proporcionado un parámetro
if [ $# -eq 0 ]; then
    echo "Error: Se requiere un parámetro" >&2
    exit 1
fi

# Guardamos el parámetro
param="$1"
if [ -n "$2" ]; then
    message="$2"
fi
input=$(cat)

# Creamos un archivo temporal para el resultado
temp_file=$(mktemp /tmp/vi-bridge.XXXX)

echo "$input" > "$temp_file"

# MODEL="codegeex4"
# MODEL="llama3.1"
MODEL="yi-coder"
# MODEL="phi3.5" # bad
# MODEL="deepseek-coder-v2"

LARAVEL_FILL_FILE="~/.vim/plugged/vim-intelligence-bridge/script/code/laravel/prompt.txt"
LARAVEL_DEVEL_FILE="~/.vim/plugged/vim-intelligence-bridge/script/code/laravel/devel.txt"
LARAVEL_SYSTEM_FILE="~/.vim/plugged/vim-intelligence-bridge/script/code/laravel/system.txt"

PROMPT=""
LLM=""
SYSTEM=""

# Comprobamos el valor del parámetro y mostramos el mensaje correspondiente
case $param in
    "groq/code/laravel/devel")
        LLM="GROQ"
        PROMPT="00"
        ;;
    "ollama/code/laravel/devel")
        LLM="OLLAMA"
        PROMPT=$(cat "$LARAVEL_DEVEL_FILE" | sed -e 's/"/\\"/g' -e 's/\$/\\$/g' | awk '{printf "%s\\n", $0}')
        SYSTEM=$(cat "$LARAVEL_SYSTEM_FILE" | sed -e 's/"/\\"/g' -e 's/\$/\\$/g' | awk '{printf "%s\\n", $0}')
        ;;
    "code/laravel/fill")
        PROMPT="Te asegurarás de reemplazar todas las keywords \"//fill\" con el el código más adecuado según el contexto dentro del cual se encuentre, sin modificar ninguna otra parte del código, de manera que entregarás todo el código original con los reemplazos pertinentes"
        ;;
    "code/laravel/comment")
        echo "Voy a documentar el código fuente"
        ;;
    "code/laravel/explain")
        echo "Voy a explicar el código fuente"
        ;;
    "code/laravel/fix")
        echo "Voy a corregir el código fuente"
        ;;
    "prompt")
        echo "Voy a responder en base a tu pregunta"
        ;;
    *)
        echo "Parámetro no reconocido. Por favor, utiliza uno de los siguientes: code/laravel/fill, code/laravel/comment, code/laravel/explain, code/laravel/fix, prompt."
        exit 1
        ;;
esac

case $LLM in
    "OLLAMA")
        ollama run "$MODEL" """
        $SYSTEM
        
        $PROMPT
        
        El archivo sobre el que vas a trabajar es el siguiente:
        
        $(cat $temp_file)
        """
        ;;
    "GROQ")
        ~/.vim/plugged/vim-intelligence-bridge/script/groq/launcher.sh $PROMPT $temp_file
        ;;
    *)
        echo "No se ha elegido LLM"
        ;;
esac       

