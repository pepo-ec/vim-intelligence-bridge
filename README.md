# Vim Intelligence Bridge

## Descripción
Vim Intelligence Bridge es un plugin para Vim que integra capacidades de inteligencia artificial en tu flujo de trabajo de desarrollo (extendible a cualquier otro ámbito). Diseñado para trabajar con Ollama localmente (prioriza la privacidad), también ofrece soporte para la API de Groq, mejorando la productividad y la experiencia de codificación.

## Características
- Integración seamless con Vim
- Utiliza Ollama para procesamiento de lenguaje natural local y privado
- Soporte opcional para la API de Groq para procesamiento en la nube
- Mejora la productividad en tareas de codificación
- Personalizable para diferentes lenguajes de programación
- Prioriza la privacidad y el rendimiento con procesamiento local

## Requisitos
- Vim 8.0+
- Python 3.6+
- Ollama instalado localmente (recomendado)
- Conexión a Internet solo si se usa la API de Groq (opcional)

## Instalación

### Usando un gestor de plugins (recomendado)
Si usas [vim-plug](https://github.com/junegunn/vim-plug), agrega esto a tu archivo de configuración de Vim (`.vimrc`):

```vim
Plug 'pepo-ec/vim-intelligence-bridge'
```

Luego, ejecuta `:PlugInstall` en Vim.

### Instalación manual
Clona el repositorio en tu directorio de plugins de Vim:

```bash
git clone https://github.com/pepo-ec/vim-intelligence-bridge.git ~/.vim/pack/plugins/start/vim-intelligence-bridge
```

## Configuración
1. Crea un archivo `.env` en el directorio `~/.vim/plugged/vim-intelligence-bridge/` para las claves API (si usas Groq):

   ```
   API_GROQ=tu_api_key_aqui
   ```

2. Crea un archivo `config.env` en el mismo directorio para las configuraciones no secretas:

   ```
   OLLAMA_MODEL=llama3.1
   GROQ_MODEL=llama-3.1-70b-versatile
   ```

3. Ajusta los valores en `config.env` según tus preferencias.

## Uso
- Comando principal: `:IntelligenceBridge`
- Atajo de teclado predeterminado: `<leader>ib`

Ejemplo de uso:
1. Selecciona un bloque de código en modo visual.
2. Presiona `<leader>ib` o ejecuta `:IntelligenceBridge`.
3. Ingresa tu consulta cuando se te solicite.
    3.1. **ollama/code/laravel/devel** Este comando enviará el contexto hacia Ollama (Es más lento pero lo elijo para mantener mi privacidad)
    3.2. **groq/code/laravel/devel** Este comando enviará el contexto a Groq que hace un excelente trabajo de manera gratuita y extremadamente rápido
4. El plugin procesará tu consulta y el código seleccionado usando Ollama (o Groq si está configurado), y mostrará los resultados.

    4.1 Definición del contexto. Esta es la manera que se delimita el alcance del LLM

    **code/laravel/devel** Cuando se ha usado una de las variantes devel los requerimientos son bloques que están delimitados por las palabras clave inicio_requerimiento y fin_requerimiento, por ejemplo:

    El código con el requrimiento podría ser algo similar a lo siguiente:

    ```php
    public function update(Request $request, $id)
    {
        //inicio_requerimiento
        // En este segmento quiero que agregues el código más común que en Laravel sirva para actualizar un modelo User
        //fin_requerimiento
    }
    ```

    Luego de invocar al plugin (uso), la respuesta esperada sería algo similar a lo siguiente:

    ```php
    public function update(Request $request, $id)
    {
        $user = User::find($id);
        if ($request->input('password')) {
            $user->password = bcrypt($request->input('password'));
        }
        $user->name = $request->input('name');
        $user->email = $request->input('email');
        $user->save();
        return redirect()->route('users.index')->with('success', 'Usuario actualizado correctamente');
    }
    ```

## Personalización
Puedes personalizar el comportamiento del plugin editando tu `config.env`. Ejemplo:

```
OLLAMA_MODEL=codellama
GROQ_MODEL=llama-3.1-70b-versatile
```

## APIs y Plataformas Utilizadas
- [Ollama](https://ollama.ai/): Plataforma local para ejecución de modelos de IA, proporcionando privacidad y eficiencia (recomendado).
- [Groq API](https://console.groq.com/): Para procesamiento de lenguaje natural en la nube (opcional).

## Contribuir
Las contribuciones son bienvenidas! Por favor, lee [CONTRIBUTING.md](CONTRIBUTING.md) para detalles sobre nuestro código de conducta y el proceso para enviarnos pull requests.

## Licencia
Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para más detalles.

## Soporte
Si encuentras algún problema o tienes alguna sugerencia, por favor abre un issue en el [rastreador de problemas de GitHub](https://github.com/pepo-ec/vim-intelligence-bridge/issues).

## Agradecimientos
- Agradecemos al equipo de Ollama por proporcionar una excelente plataforma local para IA.
- A Groq por su API como alternativa en la nube.
- A todos los contribuidores y usuarios que ayudan a mejorar este plugin.

