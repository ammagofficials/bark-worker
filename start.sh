#!/bin/bash
set -e

echo "Installing basic dependencies..."
pip install -r requirements.txt

echo "Installing soundfile..."
pip install soundfile

echo "Installing Bark from GitHub..."
pip install git+https://github.com/suno-ai/bark.git

echo "Starting app..."
python rp_handler.py
