# Intelligence Bridge

Un plugin de Vim que crea un puente entre tu editor y procesos de inteligencia externos, permitiendo procesar texto seleccionado usando scripts personalizados.

## Instalación

### Usando [vim-plug](https://github.com/junegunn/vim-plug)

Añade esto a tu `~/.vimrc`:

```vim
Plug 'pepo-ec/vim-intelligence-bridge'
```

## Configuración

### Nombres de modelos, etc.

Para configurar los nombres de los modelos es necesario hacerlo en el archivo **$BASE_INSTALL/config.env**

```
GROQ_MODEL=llama-3.1-70b-versatile
OLLAMA_MODEL=yi-coder
```

### APIs, secretos, etc.

Para configurar la información sensible como las llaves de APIs se debe modificar el archivo **$BASE_INSTALL/.env**

```
API_GROQ=01234567890123456789012345678901234567890123456789012345
```

Se provee el archivo env.example que puede ser renombrado y luego correctamente configurado:

```bash
cp env.example .env
```

## Uso

1. Usando [Vim](https://www.vim.org/) en modo _visual_ seleccionar el texto que va a generar el contexto.
2. Presionar la tecla _"Leader"_ seguido de _ib_ (en mi caso: **,ib**)
3. Se pedirá que ingrese el comando para trabajar con el contexto ()al momento sólo he agregado comandos para **desarrollar software** pero eso va a cambiar en el futuro próximo)
    - **ollama/code/laravel/devel** Este comando enviará el contexto hacia Ollama (Es más lento pero lo elijo para mantener mi privacidad)
    - **groq/code/laravel/devel** Este comando enviará el contexto a Groq que hace un excelente trabajo de manera gratuita y extremadamente rápido

### Definición del contexto

Esta es la manera que se delimita el alcance del LLM

#### code/laravel/devel

Cuando se ha usado una de las variantes **devel** los requerimientos son bloques que están delimitados por las palabras clave **//inicio_requerimiento** y **//fin_requerimiento**, por ejemplo:

El código con el requrimiento podría ser algo similar a lo siguiente:

```php
public function update(Request $request, $id)
{
    //inicio_requerimiento
    // En este segmento quiero que agregues el código más común que en Laravel sirva para actualizar un modelo User
    //fin_requerimiento
}
```

Luego de invocar al plugin (**uso**), la respuesta esperada sería algo similar a lo siguiente:

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

---

## Notas

### Automatización

Caundo se usa GROQ el plugin establece la interconexión a través de un script de Python, para no modificar innecesariamente el sistema operativo se configura un entorno virtual para allí instalar todas las dependencias, este proceso es automático y se ejecuta la primera vez que se invoca al _plugin_ (internamente se ejecuta el siguiente comando):

```bash
python3 -m venv venv
```

### APIs integradas

Al momento se puede desarrollar con las siguientes APIs:

- Ollama
- Groq

Espero ampliar este listado en el futuro próximo
