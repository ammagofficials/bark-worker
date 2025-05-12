#!/bin/bash
set -e

echo "Installing requirements..."
pip install -r requirements.txt

echo "Installing soundfile manually..."
pip install soundfile

echo "Installing Bark from GitHub..."
pip install git+https://github.com/suno-ai/bark.git

echo "Starting main app..."
python rp_handler.py
