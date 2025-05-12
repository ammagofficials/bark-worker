#!/bin/bash
set -e

echo "Installing CUDA-enabled PyTorch..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

echo "Installing basic Python requirements..."
pip install -r requirements.txt

echo "Installing soundfile..."
pip install soundfile

echo "Installing Transformers (latest from HuggingFace GitHub)..."
pip install git+https://github.com/huggingface/transformers.git

echo "Installing Bark from GitHub..."
pip install git+https://github.com/suno-ai/bark.git

echo "Starting app..."
python rp_handler.py