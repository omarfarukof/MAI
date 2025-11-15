FROM nvidia/cuda:13.0.0-devel-ubuntu24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git python3 python3-pip python3-venv libgl1 wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# PyTorch nightly with CUDA 13 support (available since 29-Aug-2025)
# ----- venv approach -----
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

RUN pip install --upgrade pip
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130
RUN pip install -r requirements.txt

# optional but useful nodes
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager
RUN pip install -r custom_nodes/ComfyUI-Manager/requirements.txt

RUN git clone https://github.com/city96/ComfyUI-GGUF custom_nodes/ComfyUI-GGUF
RUN pip install --upgrade gguf

EXPOSE 8188
CMD ["python3","main.py","--listen","0.0.0.0","--port","8188"]