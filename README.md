# Intelligence Bridge

Un plugin de Vim que crea un puente entre tu editor y procesos de inteligencia externos, permitiendo procesar texto seleccionado usando scripts personalizados.

## Instalación

### Usando [vim-plug](https://github.com/junegunn/vim-plug)

Añade esto a tu `~/.vimrc`:

```vim
Plug 'pepo-ec/vim-intelligence-bridge'
```

### Automatización

Al momento el plugin crea el entorno virtual de Python usando _python3 -m venv venv_

---

## APIs integradas

- Ollama
- Groq
