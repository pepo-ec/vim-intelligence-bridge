#!/bin/bash

# Definir la ruta al entorno virtual y al script Python
VENV_PATH="$HOME/.vim/plugged/vim-intelligence-bridge/script/groq/venv"
PYTHON_SCRIPT="$HOME/.vim/plugged/vim-intelligence-bridge/script/groq/main.py"

# Verificar si el entorno virtual existe
if [ ! -d "$VENV_PATH" ]; then
    echo "Error: El entorno virtual no existe en $VENV_PATH"
    echo "Por favor, crea el entorno virtual primero con: python3 -m venv venv"
    exit 1
fi

# Verificar si el script Python existe
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "Error: El script $PYTHON_SCRIPT no existe"
    exit 1
fi

echo "Segunda verificación" >> /tmp/prueba.txt

# Activar el entorno virtual
source "$VENV_PATH/bin/activate"

# Verificar si la activación fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: No se pudo activar el entorno virtual"
    exit 1
fi

# Ejecutar el script Python
python "$PYTHON_SCRIPT" "$@"

# Capturar el código de salida del script Python
PYTHON_EXIT_CODE=$?

# Desactivar el entorno virtual
deactivate

# Salir con el mismo código de salida que el script Python
exit $PYTHON_EXIT_CODE
