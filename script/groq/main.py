import os
import sys
from dotenv import load_dotenv
from groq import Groq

GROQ_MODEL=""

def leer_env():
    global GROQ_MODEL
    # Obtener el valor de la variable de entorno HOME
    home = os.environ.get('HOME')
    if not home:
        raise ValueError("La variable de entorno HOME no está definida")
    # Construir la ruta al archivo .env
    ruta_env = os.path.join(home, '.vim', 'plugged', 'vim-intelligence-bridge', '.env')
    # Verificar si el archivo .env existe
    if not os.path.exists(ruta_env):
        raise FileNotFoundError(f"El archivo .env no existe en la ruta: {ruta_env}")
    # Cargar las variables de entorno desde el archivo .env
    load_dotenv(ruta_env)
    # Leer la variable API_GROQ
    api_groq = os.getenv('API_GROQ')
    if api_groq is None:
        raise ValueError(f"La variable API_GROQ no está definida en el archivo {ruta_env}")

    ruta_env = os.path.join(home, '.vim', 'plugged', 'vim-intelligence-bridge', 'config.env')
    # Verificar si el archivo .env existe
    if not os.path.exists(ruta_env):
        raise FileNotFoundError(f"El archivo config.env no existe en la ruta: {ruta_env}")
    # Cargar las variables de entorno desde el archivo .env
    load_dotenv(ruta_env)
    # Leer y asignar GROQ_MODEL
    GROQ_MODEL = os.getenv('GROQ_MODEL')
    if GROQ_MODEL is None:
        print(f"Advertencia: La variable GROQ_MODEL no está definida en el archivo {ruta_env}")
    return api_groq


def call_groq(api_key, system, partial, text_file):
    global GROQ_MODEL
    client = Groq(
            api_key=api_key
    )
    prompt=f"""
    {partial}

    El archivo sobre el que vas a trabajar es el siguiente:

    {text_file}
    """
    chat_completion = client.chat.completions.create(
            messages=[
                {
                    "role": "system",
                    "content": system,
                },
                {
                    "role": "user",
                    "content":  prompt,
                }
            ],
            model=f"{GROQ_MODEL}",
        )
    print(chat_completion.choices[0].message.content)


def leer_archivo_escapado(ruta):
    try:
        with open(os.path.expanduser(ruta), 'r', encoding='utf-8') as archivo:
            return archivo.read().replace('"', '\\"').replace('$', '\\$')
    except IOError as e:
        print(f"Error al leer el archivo {ruta}: {e}", file=sys.stderr)
        sys.exit(1)


def main():
    try:
        api_groq=leer_env()
        if len(sys.argv) != 3:
            print("Uso: python script.py <00|otro> <ruta_archivo>", file=sys.stderr)
            sys.exit(1)
        primer_parametro = sys.argv[1]
        ruta_archivo = sys.argv[2]
        if primer_parametro == "00":
            system = leer_archivo_escapado("~/.vim/plugged/vim-intelligence-bridge/script/code/laravel/system.txt")
            guide = leer_archivo_escapado("~/.vim/plugged/vim-intelligence-bridge/script/code/laravel/devel.txt")
        else:
            system = ""
            prompt = ""
        archivo_texto = leer_archivo_escapado(ruta_archivo)
        call_groq(api_groq,system, guide, archivo_texto)
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
