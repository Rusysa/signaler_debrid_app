# Usamos la imagen oficial de weron como base
FROM ghcr.io/pojntfx/weron:latest

# Railway inyecta $PORT automáticamente.
# El entrypoint de weron es el binario "weron", así que solo
# pasamos el subcomando + flags via CMD.
# --laddr: weron escucha en el puerto que Render asigne.
CMD ["sh", "-c", "weron signaler --laddr :${PORT:-15325}"]
