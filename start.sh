#! /bin/sh
mkdir -p volumes
mkdir -p volumes/{comfyui-models/checkpoints,ollama,open-webui}

docker compose up -d

echo "Open WebUI at http://localhost:3000"