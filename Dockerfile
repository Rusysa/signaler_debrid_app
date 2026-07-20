# Usamos la imagen oficial de weron como base
FROM ghcr.io/pojntfx/weron:latest

# Railway inyecta $PORT automáticamente.
# El entrypoint de weron es el binario "weron", así que solo
# pasamos el subcomando + flags via CMD.
# --community-persistent: las comunidades (salas) no se destruyen
#   cuando todos los peers se desconectan — necesario para reconexión tardía.
# --addr: weron escucha en el puerto que Railway asigne.
CMD ["sh", "-c", "weron signaler --verbose --community-persistent --addr :${PORT:-15325}"]
