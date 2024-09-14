#!/bin/bash

# Definir la ruta al entorno virtual y al script Python
VENV_PATH="$HOME/.vim/plugged/vim-intelligence-bridge/script/groq/venv"
PYTHON_SCRIPT="$HOME/.vim/plugged/vim-intelligence-bridge/script/groq/main.py"
REQUIREMENTS_FILE="$HOME/.vim/plugged/vim-intelligence-bridge/script/groq/requirements.txt"

# Función para crear el entorno virtual e instalar dependencias
create_venv_and_install_deps() {
    # echo "Creando entorno virtual en $VENV_PATH..."
    python3 -m venv "$VENV_PATH"
    if [ $? -ne 0 ]; then
        echo "Error: No se pudo crear el entorno virtual"
        exit 1
    fi
    # echo "Activando el entorno virtual..."
    source "$VENV_PATH/bin/activate"
    if [ $? -ne 0 ]; then
        echo "Error: No se pudo activar el entorno virtual"
        exit 1
    fi
    # echo "Instalando dependencias..."
    if [ -f "$REQUIREMENTS_FILE" ]; then
        pip install -r "$REQUIREMENTS_FILE" 2>&1 > /dev/null
    else
        # echo "Advertencia: El archivo requirements.txt no existe en $REQUIREMENTS_FILE"
        # echo "Instalando dependencias mínimas..."
        pip install python-dotenv groq 2>&1 > /dev/null
    fi
    if [ $? -ne 0 ]; then
        echo "Error: No se pudieron instalar las dependencias"
        deactivate
        exit 1
    fi
    # echo "Entorno virtual creado y dependencias instaladas con éxito"
    deactivate
}


# Verificar si el entorno virtual existe, si no, crearlo
if [ ! -d "$VENV_PATH" ]; then
    # echo "El entorno virtual no existe. Creándolo ahora..."
    create_venv_and_install_deps
fi

# Verificar si el script Python existe
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "Error: El script $PYTHON_SCRIPT no existe"
    exit 1
fi

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
