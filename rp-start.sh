FROM python:3.10-slim

# -------- System dependencies --------
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# -------- Working directory --------
WORKDIR /app

# -------- Install CUDA-enabled PyTorch --------
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# -------- Copy local code --------
COPY . .

# -------- Install Bark + Transformers + other Python deps --------
RUN pip install --no-cache-dir \
    soundfile \
    scipy \
    numpy \
    tokenizers \
    git+https://github.com/huggingface/transformers.git \
    git+https://github.com/suno-ai/bark.git

# -------- Run your handler --------
CMD ["python", "rp_handler.py"]