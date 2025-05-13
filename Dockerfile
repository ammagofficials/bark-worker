FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Update pip
RUN pip install --no-cache-dir --upgrade pip

# Working directory
WORKDIR /app

# Install PyTorch 2.7.0 with CUDA 12.1
RUN pip install --no-cache-dir torch==2.7.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 \
    && python -c "import torch; print('PyTorch version:', torch.__version__)" > /app/pytorch_version.txt

# Copy project code
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir \
    runpod \
    soundfile \
    scipy \
    numpy \
    tokenizers \
    safetensors \
    transformers==4.31.0

# Start your app
CMD ["python3", "rp_handler.py"]