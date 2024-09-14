#!/bin/bash

# Nombre del script: intelligence_bridge.sh

# Verificamos si se ha proporcionado un parámetro
if [ $# -eq 0 ]; then
    echo "Error: Se requiere un parámetro" >&2
    exit 1
fi

SCRIPTS_DIR="$HOME/.vim/plugged/vim-intelligence-bridge/script"

# Guardamos el parámetro
param="$1"
if [ -n "$2" ]; then
    message="$2"
fi
input=$(cat)

# Creamos un archivo temporal para el resultado
temp_file=$(mktemp /tmp/vi-bridge.XXXX)
echo "$input" > "$temp_file"

# Comprobamos el valor del parámetro y mostramos el mensaje correspondiente
case $param in
    "groq/code/laravel/devel")
        LLM="GROQ"
        PROMPT="00"
        ;;
    "ollama/code/laravel/devel")
        LLM="OLLAMA"
        PROMPT="00"
        ;;
    "prompt")
        echo "Voy a responder en base a tu pregunta"
        ;;
    *)
        echo "Parámetro no reconocido. Por favor, utiliza uno de los siguientes: {llm}/laravel/devel, prompt."
        exit 1
        ;;
esac

#TODO: Este árbol condicional no es eficiente ya que puede ir en el anterior, sin embargo, lo mantengo para revisar las mejores opciones para integrar otros LLM en el futuro ;)
case $LLM in
    "OLLAMA")
        $SCRIPTS_DIR/ollama/launcher.sh $PROMPT $temp_file
        ;;
    "GROQ")
        $SCRIPTS_DIR/groq/launcher.sh $PROMPT $temp_file
        ;;
    *)
        echo "No se ha elegido LLM"
        ;;
esac       

