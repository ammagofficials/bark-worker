FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /app

# Install PyTorch with CUDA 11.8
RUN pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu126

# Copy project code
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir \
    runpod \
    soundfile \
    scipy \
    numpy \
    tokenizers \
    git+https://github.com/huggingface/transformers.git \
    git+https://github.com/suno-ai/bark.git

# Start your app
CMD ["python3", "rp_handler.py"]
