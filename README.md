# weron Signaling Server — Railway Deploy

Servidor de señalización para el proyecto Watch Party.
Solo participa en el **handshake inicial** de WebRTC entre peers.
Una vez conectados, el tráfico de control (play/pause/seek) va directo P2P.

## Estructura

```
signaler/
├── Dockerfile      # Imagen basada en ghcr.io/pojntfx/weron:latest
└── railway.toml    # Configuración de deploy para Railway
```

## Cómo hacer deploy en Railway

### Opción A: desde GitHub (recomendado)

1. Sube la carpeta `signaler/` a un repo de GitHub (puede ser un repo aparte
   o el mismo repo principal del proyecto).
2. Ve a [railway.com](https://railway.com) → **New Project** → **Deploy from GitHub repo**.
3. Selecciona el repo y apunta el **Root Directory** a `signaler/`.
4. Railway detecta el `Dockerfile` y el `railway.toml` automáticamente.
5. Haz clic en **Deploy** — en ~2 minutos tendrás una URL pública tipo:
   `https://tu-signaler.up.railway.app`

### Opción B: Railway CLI

```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Login
railway login

# Desde dentro de la carpeta signaler/
cd signaler
railway init          # crea un nuevo proyecto
railway up            # sube y despliega
railway domain        # genera el dominio público
```

## URL resultante

Railway asigna una URL pública automáticamente, por ejemplo:
```
wss://tu-signaler.up.railway.app
```

Esta es la URL que configurarás en la app (Go/Wails) como `--addr` del cliente weron:
```go
// En tu código Go, la URL del signaler queda así:
signalerURL := "wss://tu-signaler.up.railway.app"
```

## Costos

- Railway da **$5 USD de crédito mensual** en el plan Hobby gratuito.
- El signaler consume muy poca RAM (~20-30 MB) y casi nada de CPU cuando está idle.
- Estimado: el signaler debería correr **todo el mes dentro del crédito gratuito**.
- No hace spin-down (a diferencia de Render free tier) — siempre disponible.

## Notas importantes

- `--community-persistent`: las salas (comunidades) **no se destruyen** cuando
  todos los peers se desconectan. Necesario para permitir reconexión tardía (ver 5.2
  del plan de diseño).
- El puerto lo inyecta Railway vía la variable `$PORT` — el Dockerfile lo toma
  automáticamente con `${PORT:-15325}`.
- Railway genera un certificado TLS automático → la URL es `wss://` (WebSocket
  seguro), que es lo que weron necesita para producción.
