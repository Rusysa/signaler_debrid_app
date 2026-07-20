# weron Signaling Server — Render Deploy

Servidor de señalización para el proyecto Watch Party.
Solo participa en el **handshake inicial** de WebRTC entre peers.

## Estructura

```
signaler/
├── Dockerfile      # Imagen basada en ghcr.io/pojntfx/weron:latest
└── render.yaml     # Blueprint de configuración para Render
```

## Cómo hacer deploy en Render

1. Sube esta carpeta `signaler/` a un repo de GitHub.
2. Ve a [render.com](https://render.com) → **Dashboard** → **New** → **Blueprint**.
3. Selecciona tu repositorio.
4. Render leerá el archivo `render.yaml` y configurará el "Web Service" automáticamente en el plan gratuito.
5. Haz clic en **Apply** — en un par de minutos tendrás una URL pública tipo:
   `https://tu-signaler.onrender.com`

## URL resultante

Render genera un certificado TLS automático, así que la URL segura (WebSocket) será:
```
wss://tu-signaler.onrender.com
```

Esta es la URL que debes pegar en el panel de **Configuración del signaler (⚙️)** de la app.

## Notas sobre el error previo
El error `invalid argument "--community-persistent" for "-v, --verbose" flag` ya fue solucionado en el `Dockerfile`. Las versiones recientes de `weron` usan `--laddr` para el puerto y administran las comunidades persistentes por defecto. El comando final ha quedado limpio como: `weron signaler --laddr :${PORT:-15325}`.
