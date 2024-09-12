#!/bin/bash

# Nombre del script: intelligence_bridge.sh

# Verificamos si se ha proporcionado un parámetro
if [ $# -eq 0 ]; then
    echo "Error: Se requiere un parámetro" >&2
    exit 1
fi

# Guardamos el parámetro
param="$1"

# Procesamos la entrada estándar
while IFS= read -r line; do
    echo "$line $param"
done | sort -n
